-- 一个链式实现的栈
class StackNode {
    -- Int / + / s / e / d / x
    command : StackCommand;
    next : StackNode;

    init(co: StackCommand, ne: StackNode): StackNode {
        {
            -- if(isvoid ne) then
            --     (new IO).out_string("ne is null\n")
            -- else
            --     (new IO).out_string("ne is not null\n")
            -- fi;
            command <- co;
            next <- ne;
            self;
        }
    };

    putOnTop(co: StackCommand): StackNode {
        let newNode: StackNode in {
            -- (new IO).out_string("putOnTop\n");
            newNode <- (new StackNode).init(co, self);
            newNode;
        }
    };

    getCommand(): StackCommand {
        command
    };

    getNext(): StackNode {
        next
    };

    setNext(node: StackNode): StackNode {
        next <- node
    };
};

-- 执行栈命令(int, +, s, d)的基类
class StackCommand {

   getChar(): String {
      "Called from base class"
   };

   execute(node: StackNode): StackNode {
      let ret: StackNode in {
         (new IO).out_string("Undefined execution!\n");
        node;
      }
   };

   getNumber(): Int {
      0
   };
};

class IntCommand inherits StackCommand {
    number : Int;

    getChar(): String {
        (new A2I).i2a(number)
    };

    init(num: Int): IntCommand {
        {
            -- (new IO).out_string("init int\n");
            number <- num;
            self;
        }
    };

    -- int不需要对栈进行操作
    execute(node: StackNode): StackNode {
        node
    };

    getNumber(): Int {
      number
   };
};

class PlusCommand inherits StackCommand {
    getChar(): String {
        "+"
    };

    init(): PlusCommand {
        self
    };

    execute(node: StackNode): StackNode {
        {
            -- 去掉栈中的+号
            node <- node.getNext();
            let firstNode: StackNode <- {
                node;
            }, secondNode: StackNode <- {
                node.getNext();
            }, sum: Int,
            ret: StackNode in {
                if (not(isvoid firstNode)) then {
                    if(not(isvoid secondNode)) then {
                        sum <- firstNode.getCommand().getNumber() + secondNode.getCommand().getNumber();
                        ret <- (new StackNode).init((new IntCommand).init(sum), secondNode.getNext());
                    } 
                    else 0
                    fi;
                }
                else 0
                fi;
                ret;
            };
        }
    };
};

class SwapCommand inherits StackCommand {
    init(): SwapCommand {
        self
    };

    getChar(): String{
        "s"
    };

    execute(node: StackNode): StackNode {
        {
            -- 去掉栈中的"s"
            node <- node.getNext();
            let firstNode: StackNode <- {
                node;
            }, secondNode: StackNode <- {
                node.getNext();
            } in {
                -- 因为结构是链式的，所以只需要交换两个节点的next指针
                firstNode.setNext(secondNode.getNext());
                secondNode.setNext(firstNode);
                secondNode;
            };
        }
    };
};

class Main inherits A2I {
    stackTop: StackNode;

    pushCommand(command: StackCommand): StackCommand{
        {
            let nil: StackNode in{
                if (isvoid stackTop) then {
                    -- (new IO).out_string("init Stack\n");
                    -- if(isvoid nil) then
                    --     (new IO).out_string("nil is null\n")
                    -- else
                    --     (new IO).out_string("nil is not null\n")
                    -- fi;

                    stackTop <- (new StackNode).init(command, nil);

                } else {
                    stackTop <- stackTop.putOnTop(command);
                }
                fi;
                command;
            };
        }
    };

    popCommand(): StackCommand{
        let ret: StackCommand in {
            if (isvoid stackTop) then {
                ret <- new StackCommand;
            } else {
                ret <- stackTop.getCommand();
                stackTop <- stackTop.getNext();
            }
            fi;
            ret;
        }
    };

    -- d命令
    printStack(): Object {
        {
            let node: StackNode <- stackTop,
                i: Int <- 1 in {
                while (not(isvoid node)) loop {
                    -- (new IO).out_string("Loop ".concat((new A2I).i2a(i)).concat("\n"));
                    i <- i + 1;
                    if(isvoid(node.getCommand())) then {
                        (new IO).out_string("null\n");
                    } else {
                        (new IO).out_string("|\t".concat(node.getCommand().getChar()).concat("\t|\n"));
                    }
                    fi;
                    --(new IO).out_string("|".concat(node.getCommand().getChar()).concat("|\n"));
                    --(new IO).out_string("next: ".concat(node.getNext().getCommand().getChar()).concat("\n"));
                    node <- node.getNext();
                }
                pool;
            };
        }
    };

    executeInStr(inStr: String): Object {
        -- display
        if (inStr = "d") then {
            printStack();
        }
        else 
            -- push +
            if (inStr = "+") then {
                pushCommand((new PlusCommand).init());
                -- log
                -- (new IO).out_string(">>>Pushed: ".concat(inStr).concat("\n"));
            }
            else 
                -- push swap
                if (inStr = "s") then {
                    pushCommand((new SwapCommand).init());
                    -- log
                    -- (new IO).out_string(">>>Pushed: ".concat(inStr).concat("\n"));
                }
                else 
                    -- 执行一次
                    if (inStr = "e") then {
                        let node: StackNode <- stackTop in {
                            if (not (isvoid node)) then
                                stackTop <- node.getCommand().execute(node)
                            else
                                0
                            fi;
                        };
                    }
                    else
                        {
                            -- push int
                            pushCommand((new IntCommand).init((new A2I).a2i(inStr)));
                            -- log
                            -- (new IO).out_string(">>>Pushed: ".concat(inStr).concat("\n"));
                        }
                    fi
                fi
            fi 
        fi

    };

    main(): Object{
        {
            
            (new IO).out_string(">");
            
            let inStr: String <- (new IO).in_string() in {
                while (not(inStr = "x")) loop {
                    executeInStr(inStr);
                    (new IO).out_string(">");
                    inStr <- (new IO).in_string();
                }
                pool;
                (new IO).out_string("Bye!\n");
            };
        }
    };
};
class List inherits A2I {
    item: Object;
    next: List;

    init(i: Object, n: List): List {
        {
            item <- i;
            next <- n;
            self;
        }
    };

    flatten(): String{
        let string: String <-
            case item of
                i: Int => i2a(i);
                s: String => s;
                o: Object => {
                    abort();
                    "";         -- 否则报错: Inferred type Object of initialization of string does not conform to identifier's declared type String.
                                -- 因为case语句要求返回String类型, 但是o是Object类型, 所以报错
                                -- 使用块语句, 返回值是块语句的最后一个表达式的值, 即`""`(空字符串)
                    }; 
            esac
        in
            if (isvoid next) then
                string
            else
                string.concat(next.flatten())
            fi
    };
};

class Main inherits IO {
    main(): Object {
        let hello: String <- "Hello ",
            world: String <- "World!",
            newLine: String <- "\n",
            i: Int <- 1,
            nil: List,                              -- nil: 空指针(因为cool语言没有null, 所以定义一个nil代替)
            list: List <- 
                (new List).init(hello,
                    (new List).init(world,
                        (new List).init(newLine, 
                            (new List).init(i, (new List).init(newLine, nil)))))
        in
            out_string(list.flatten())
    }; 
};
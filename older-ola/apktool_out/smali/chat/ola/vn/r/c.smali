.class public Lchat/ola/vn/r/c;
.super Ljava/lang/Object;


# static fields
.field public static a:[Lchat/ola/vn/entry/h;

.field public static b:[Lchat/ola/vn/entry/h;

.field public static c:[Lchat/ola/vn/entry/h;

.field public static d:[Lchat/ola/vn/entry/h;

.field public static e:[Lchat/ola/vn/entry/h;


# direct methods
.method static constructor <clinit>()V
    .locals 18

    const/16 v0, 0x2d

    new-array v0, v0, [Lchat/ola/vn/entry/h;

    new-instance v1, Lchat/ola/vn/entry/h;

    const/4 v2, 0x2

    new-array v3, v2, [Ljava/lang/String;

    const-string v4, ":-)"

    const/4 v5, 0x0

    aput-object v4, v3, v5

    const-string v4, ":)"

    const/4 v6, 0x1

    aput-object v4, v3, v6

    const v4, 0x7f08082d

    invoke-direct {v1, v4, v5, v3}, Lchat/ola/vn/entry/h;-><init>(IS[Ljava/lang/String;)V

    aput-object v1, v0, v5

    new-instance v1, Lchat/ola/vn/entry/h;

    const/4 v3, 0x4

    new-array v4, v3, [Ljava/lang/String;

    const-string v7, ":-P"

    aput-object v7, v4, v5

    const-string v7, ":-p"

    aput-object v7, v4, v6

    const-string v7, ":p"

    aput-object v7, v4, v2

    const-string v7, ":P"

    const/4 v8, 0x3

    aput-object v7, v4, v8

    const v7, 0x7f08082e

    invoke-direct {v1, v7, v5, v4}, Lchat/ola/vn/entry/h;-><init>(IS[Ljava/lang/String;)V

    aput-object v1, v0, v6

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v4, v6, [Ljava/lang/String;

    const-string v7, ">:D<"

    aput-object v7, v4, v5

    const v7, 0x7f08082f

    invoke-direct {v1, v7, v5, v4}, Lchat/ola/vn/entry/h;-><init>(IS[Ljava/lang/String;)V

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v4, v2, [Ljava/lang/String;

    const-string v7, ":-))"

    aput-object v7, v4, v5

    const-string v7, ":))"

    aput-object v7, v4, v6

    const v7, 0x7f080830

    invoke-direct {v1, v7, v5, v4}, Lchat/ola/vn/entry/h;-><init>(IS[Ljava/lang/String;)V

    aput-object v1, v0, v8

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v4, v6, [Ljava/lang/String;

    const-string v7, ":\">"

    aput-object v7, v4, v5

    const v7, 0x7f080831

    invoke-direct {v1, v7, v5, v4}, Lchat/ola/vn/entry/h;-><init>(IS[Ljava/lang/String;)V

    aput-object v1, v0, v3

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v4, v3, [Ljava/lang/String;

    const-string v7, "B-)"

    aput-object v7, v4, v5

    const-string v7, "b-)"

    aput-object v7, v4, v6

    const-string v7, "B)"

    aput-object v7, v4, v2

    const-string v7, "b)"

    aput-object v7, v4, v8

    const v7, 0x7f080832

    invoke-direct {v1, v7, v5, v4}, Lchat/ola/vn/entry/h;-><init>(IS[Ljava/lang/String;)V

    const/4 v4, 0x5

    aput-object v1, v0, v4

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v7, v3, [Ljava/lang/String;

    const-string v9, ":-X"

    aput-object v9, v7, v5

    const-string v9, ":-x"

    aput-object v9, v7, v6

    const-string v9, ":X"

    aput-object v9, v7, v2

    const-string v9, ":x"

    aput-object v9, v7, v8

    const v9, 0x7f080833

    invoke-direct {v1, v9, v5, v7}, Lchat/ola/vn/entry/h;-><init>(IS[Ljava/lang/String;)V

    const/4 v7, 0x6

    aput-object v1, v0, v7

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v9, v2, [Ljava/lang/String;

    const-string v10, ":-*"

    aput-object v10, v9, v5

    const-string v10, ":*"

    aput-object v10, v9, v6

    const v10, 0x7f080834

    invoke-direct {v1, v10, v5, v9}, Lchat/ola/vn/entry/h;-><init>(IS[Ljava/lang/String;)V

    const/4 v9, 0x7

    aput-object v1, v0, v9

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v10, v2, [Ljava/lang/String;

    const-string v11, ":-|"

    aput-object v11, v10, v5

    const-string v11, ":|"

    aput-object v11, v10, v6

    const v11, 0x7f080835

    invoke-direct {v1, v11, v5, v10}, Lchat/ola/vn/entry/h;-><init>(IS[Ljava/lang/String;)V

    const/16 v10, 0x8

    aput-object v1, v0, v10

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v11, v3, [Ljava/lang/String;

    const-string v12, ":-D"

    aput-object v12, v11, v5

    const-string v12, ":-d"

    aput-object v12, v11, v6

    const-string v12, ":D"

    aput-object v12, v11, v2

    const-string v12, ":d"

    aput-object v12, v11, v8

    const v12, 0x7f080836

    invoke-direct {v1, v12, v5, v11}, Lchat/ola/vn/entry/h;-><init>(IS[Ljava/lang/String;)V

    const/16 v11, 0x9

    aput-object v1, v0, v11

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v12, v2, [Ljava/lang/String;

    const-string v13, ";-)"

    aput-object v13, v12, v5

    const-string v13, ";)"

    aput-object v13, v12, v6

    const v13, 0x7f080837

    invoke-direct {v1, v13, v5, v12}, Lchat/ola/vn/entry/h;-><init>(IS[Ljava/lang/String;)V

    const/16 v12, 0xa

    aput-object v1, v0, v12

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v13, v2, [Ljava/lang/String;

    const-string v14, "|-)"

    aput-object v14, v13, v5

    const-string v14, "|)"

    aput-object v14, v13, v6

    const v14, 0x7f080838

    invoke-direct {v1, v14, v5, v13}, Lchat/ola/vn/entry/h;-><init>(IS[Ljava/lang/String;)V

    const/16 v13, 0xb

    aput-object v1, v0, v13

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [Ljava/lang/String;

    const-string v15, "(:|"

    aput-object v15, v14, v5

    const v15, 0x7f080839

    invoke-direct {v1, v15, v5, v14}, Lchat/ola/vn/entry/h;-><init>(IS[Ljava/lang/String;)V

    const/16 v14, 0xc

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v15, v6, [Ljava/lang/String;

    const-string v16, ":-/"

    aput-object v16, v15, v5

    const v14, 0x7f08083a

    invoke-direct {v1, v14, v5, v15}, Lchat/ola/vn/entry/h;-><init>(IS[Ljava/lang/String;)V

    const/16 v14, 0xd

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v15, v2, [Ljava/lang/String;

    const-string v16, ":-<"

    aput-object v16, v15, v5

    const-string v16, ":<"

    aput-object v16, v15, v6

    const v14, 0x7f08083b

    invoke-direct {v1, v14, v5, v15}, Lchat/ola/vn/entry/h;-><init>(IS[Ljava/lang/String;)V

    const/16 v14, 0xe

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v2, [Ljava/lang/String;

    const-string v15, ":-&"

    aput-object v15, v14, v5

    const-string v15, ":&"

    aput-object v15, v14, v6

    const v15, 0x7f08083c

    invoke-direct {v1, v15, v5, v14}, Lchat/ola/vn/entry/h;-><init>(IS[Ljava/lang/String;)V

    const/16 v14, 0xf

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v2, [Ljava/lang/String;

    const-string v15, ":-("

    aput-object v15, v14, v5

    const-string v15, ":("

    aput-object v15, v14, v6

    const v15, 0x7f08083d

    invoke-direct {v1, v15, v5, v14}, Lchat/ola/vn/entry/h;-><init>(IS[Ljava/lang/String;)V

    const/16 v14, 0x10

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v3, [Ljava/lang/String;

    const-string v15, ":-B"

    aput-object v15, v14, v5

    const-string v15, ":-b"

    aput-object v15, v14, v6

    const-string v15, ":B"

    aput-object v15, v14, v2

    const-string v15, ":b"

    aput-object v15, v14, v8

    const v15, 0x7f08083e

    invoke-direct {v1, v15, v5, v14}, Lchat/ola/vn/entry/h;-><init>(IS[Ljava/lang/String;)V

    const/16 v14, 0x11

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v3, [Ljava/lang/String;

    const-string v15, ":-O"

    aput-object v15, v14, v5

    const-string v15, ":-o"

    aput-object v15, v14, v6

    const-string v15, ":O"

    aput-object v15, v14, v2

    const-string v15, ":o"

    aput-object v15, v14, v8

    const v15, 0x7f08083f

    invoke-direct {v1, v15, v5, v14}, Lchat/ola/vn/entry/h;-><init>(IS[Ljava/lang/String;)V

    const/16 v14, 0x12

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v3, [Ljava/lang/String;

    const-string v15, ":-h"

    aput-object v15, v14, v5

    const-string v15, ":-H"

    aput-object v15, v14, v6

    const-string v15, ":h"

    aput-object v15, v14, v2

    const-string v15, ":H"

    aput-object v15, v14, v8

    const v15, 0x7f080840

    invoke-direct {v1, v15, v5, v14}, Lchat/ola/vn/entry/h;-><init>(IS[Ljava/lang/String;)V

    const/16 v14, 0x13

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v3, [Ljava/lang/String;

    const-string v15, ":-S"

    aput-object v15, v14, v5

    const-string v15, ":-s"

    aput-object v15, v14, v6

    const-string v15, ":S"

    aput-object v15, v14, v2

    const-string v15, ":s"

    aput-object v15, v14, v8

    const v15, 0x7f080841

    invoke-direct {v1, v15, v5, v14}, Lchat/ola/vn/entry/h;-><init>(IS[Ljava/lang/String;)V

    const/16 v14, 0x14

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v2, [Ljava/lang/String;

    const-string v15, ":-?"

    aput-object v15, v14, v5

    const-string v15, ":?"

    aput-object v15, v14, v6

    const v15, 0x7f080842

    invoke-direct {v1, v15, v5, v14}, Lchat/ola/vn/entry/h;-><init>(IS[Ljava/lang/String;)V

    const/16 v14, 0x15

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v2, [Ljava/lang/String;

    const-string v15, ":-(("

    aput-object v15, v14, v5

    const-string v15, ":(("

    aput-object v15, v14, v6

    const v15, 0x7f080843

    invoke-direct {v1, v15, v5, v14}, Lchat/ola/vn/entry/h;-><init>(IS[Ljava/lang/String;)V

    const/16 v14, 0x16

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [Ljava/lang/String;

    const-string v15, "=(("

    aput-object v15, v14, v5

    const v15, 0x7f080844

    invoke-direct {v1, v15, v5, v14}, Lchat/ola/vn/entry/h;-><init>(IS[Ljava/lang/String;)V

    const/16 v14, 0x17

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [Ljava/lang/String;

    const-string v15, "=;"

    aput-object v15, v14, v5

    const v15, 0x7f080845

    invoke-direct {v1, v15, v5, v14}, Lchat/ola/vn/entry/h;-><init>(IS[Ljava/lang/String;)V

    const/16 v14, 0x18

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v3, [Ljava/lang/String;

    const-string v15, ":-W"

    aput-object v15, v14, v5

    const-string v15, ":-w"

    aput-object v15, v14, v6

    const-string v15, ":W"

    aput-object v15, v14, v2

    const-string v15, ":w"

    aput-object v15, v14, v8

    const v15, 0x7f080846

    invoke-direct {v1, v15, v5, v14}, Lchat/ola/vn/entry/h;-><init>(IS[Ljava/lang/String;)V

    const/16 v14, 0x19

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v3, [Ljava/lang/String;

    const-string v15, "X-("

    aput-object v15, v14, v5

    const-string v15, "x-("

    aput-object v15, v14, v6

    const-string v15, "X("

    aput-object v15, v14, v2

    const-string v15, "x("

    aput-object v15, v14, v8

    const v15, 0x7f080847

    invoke-direct {v1, v15, v5, v14}, Lchat/ola/vn/entry/h;-><init>(IS[Ljava/lang/String;)V

    const/16 v14, 0x1a

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [Ljava/lang/String;

    const-string v15, ">:)"

    aput-object v15, v14, v5

    const v15, 0x7f080848

    invoke-direct {v1, v15, v5, v14}, Lchat/ola/vn/entry/h;-><init>(IS[Ljava/lang/String;)V

    const/16 v14, 0x1b

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [Ljava/lang/String;

    const-string v15, ";))"

    aput-object v15, v14, v5

    const v15, 0x7f080849

    invoke-direct {v1, v15, v5, v14}, Lchat/ola/vn/entry/h;-><init>(IS[Ljava/lang/String;)V

    const/16 v14, 0x1c

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [Ljava/lang/String;

    const-string v15, ">:P"

    aput-object v15, v14, v5

    const v15, 0x7f08084a

    invoke-direct {v1, v15, v5, v14}, Lchat/ola/vn/entry/h;-><init>(IS[Ljava/lang/String;)V

    const/16 v14, 0x1d

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [Ljava/lang/String;

    const-string v15, "/:)"

    aput-object v15, v14, v5

    const v15, 0x7f08084b

    invoke-direct {v1, v15, v5, v14}, Lchat/ola/vn/entry/h;-><init>(IS[Ljava/lang/String;)V

    const/16 v14, 0x1e

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [Ljava/lang/String;

    const-string v15, "<3"

    aput-object v15, v14, v5

    const v15, 0x7f08084c

    invoke-direct {v1, v15, v5, v14}, Lchat/ola/vn/entry/h;-><init>(IS[Ljava/lang/String;)V

    const/16 v14, 0x1f

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [Ljava/lang/String;

    const-string v15, "(*)"

    aput-object v15, v14, v5

    const v15, 0x7f08084d

    invoke-direct {v1, v15, v5, v14}, Lchat/ola/vn/entry/h;-><init>(IS[Ljava/lang/String;)V

    const/16 v14, 0x20

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v2, [Ljava/lang/String;

    const-string v15, "@;-"

    aput-object v15, v14, v5

    const-string v15, "@};-"

    aput-object v15, v14, v6

    const v15, 0x7f08084e

    invoke-direct {v1, v15, v5, v14}, Lchat/ola/vn/entry/h;-><init>(IS[Ljava/lang/String;)V

    const/16 v14, 0x21

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v2, [Ljava/lang/String;

    const-string v15, "(y)"

    aput-object v15, v14, v5

    const-string v15, "(Y)"

    aput-object v15, v14, v6

    const v15, 0x7f08084f

    invoke-direct {v1, v15, v5, v14}, Lchat/ola/vn/entry/h;-><init>(IS[Ljava/lang/String;)V

    const/16 v14, 0x22

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v2, [Ljava/lang/String;

    const-string v15, "(n)"

    aput-object v15, v14, v5

    const-string v15, "(N)"

    aput-object v15, v14, v6

    const v15, 0x7f080850

    invoke-direct {v1, v15, v5, v14}, Lchat/ola/vn/entry/h;-><init>(IS[Ljava/lang/String;)V

    const/16 v14, 0x23

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v15, v6, [Ljava/lang/String;

    const-string v16, "^_^"

    aput-object v16, v15, v5

    const v14, 0x7f080851

    invoke-direct {v1, v14, v5, v15}, Lchat/ola/vn/entry/h;-><init>(IS[Ljava/lang/String;)V

    const/16 v14, 0x24

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [Ljava/lang/String;

    const-string v15, ":v"

    aput-object v15, v14, v5

    const v15, 0x7f080852

    invoke-direct {v1, v15, v5, v14}, Lchat/ola/vn/entry/h;-><init>(IS[Ljava/lang/String;)V

    const/16 v14, 0x25

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [Ljava/lang/String;

    const-string v15, ":3"

    aput-object v15, v14, v5

    const v15, 0x7f080853

    invoke-direct {v1, v15, v5, v14}, Lchat/ola/vn/entry/h;-><init>(IS[Ljava/lang/String;)V

    const/16 v14, 0x26

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [Ljava/lang/String;

    const-string v15, "=))"

    aput-object v15, v14, v5

    const v15, 0x7f080854

    invoke-direct {v1, v15, v5, v14}, Lchat/ola/vn/entry/h;-><init>(IS[Ljava/lang/String;)V

    const/16 v14, 0x27

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [Ljava/lang/String;

    const-string v15, "@@"

    aput-object v15, v14, v5

    const v15, 0x7f080855

    invoke-direct {v1, v15, v5, v14}, Lchat/ola/vn/entry/h;-><init>(IS[Ljava/lang/String;)V

    const/16 v14, 0x28

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [Ljava/lang/String;

    const-string v15, "@)"

    aput-object v15, v14, v5

    const v15, 0x7f080856

    invoke-direct {v1, v15, v5, v14}, Lchat/ola/vn/entry/h;-><init>(IS[Ljava/lang/String;)V

    const/16 v14, 0x29

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [Ljava/lang/String;

    const-string v15, ":\u2019("

    aput-object v15, v14, v5

    const v15, 0x7f080857

    invoke-direct {v1, v15, v5, v14}, Lchat/ola/vn/entry/h;-><init>(IS[Ljava/lang/String;)V

    const/16 v14, 0x2a

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v8, [Ljava/lang/String;

    const-string v15, "O:)"

    aput-object v15, v14, v5

    const-string v15, "o:)"

    aput-object v15, v14, v6

    const-string v15, "0:)"

    aput-object v15, v14, v2

    const v15, 0x7f080858

    invoke-direct {v1, v15, v5, v14}, Lchat/ola/vn/entry/h;-><init>(IS[Ljava/lang/String;)V

    const/16 v14, 0x2b

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v8, [Ljava/lang/String;

    const-string v15, ">:O"

    aput-object v15, v14, v5

    const-string v15, ">:o"

    aput-object v15, v14, v6

    const-string v15, ">:0"

    aput-object v15, v14, v2

    const v15, 0x7f080859

    invoke-direct {v1, v15, v5, v14}, Lchat/ola/vn/entry/h;-><init>(IS[Ljava/lang/String;)V

    const/16 v14, 0x2c

    aput-object v1, v0, v14

    sput-object v0, Lchat/ola/vn/r/c;->a:[Lchat/ola/vn/entry/h;

    const/16 v0, 0x24

    new-array v0, v0, [Lchat/ola/vn/entry/h;

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f3ed

    aput v15, v14, v5

    const v15, 0x7f0802b5

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v5

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f3ef

    aput v15, v14, v5

    const v15, 0x7f0802b7

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v6

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f3f0

    aput v15, v14, v5

    const v15, 0x7f0802b8

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f3a2

    aput v15, v14, v5

    const v15, 0x7f080280

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v8

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f3a1

    aput v15, v14, v5

    const v15, 0x7f08027f

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v3

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f3a0

    aput v15, v14, v5

    const v15, 0x7f08027e

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v4

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f391

    aput v15, v14, v5

    const v15, 0x7f08027b

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v7

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f387

    aput v15, v14, v5

    const v15, 0x7f080271

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v9

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f386

    aput v15, v14, v5

    const v15, 0x7f080270

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v10

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f301

    aput v15, v14, v5

    const v15, 0x7f0801ff

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v11

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f303

    aput v15, v14, v5

    const v15, 0x7f080201

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v12

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f304

    aput v15, v14, v5

    const v15, 0x7f080202

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v13

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f305

    aput v15, v14, v5

    const v15, 0x7f080203

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xc

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f306

    aput v15, v14, v5

    const v15, 0x7f080204

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xd

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f307

    aput v15, v14, v5

    const v15, 0x7f080205

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xe

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f308

    aput v15, v14, v5

    const v15, 0x7f080206

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xf

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f309

    aput v15, v14, v5

    const v15, 0x7f080207

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x10

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f30b

    aput v15, v14, v5

    const v15, 0x7f080209

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x11

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f30c

    aput v15, v14, v5

    const v15, 0x7f08020a

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x12

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f5fb

    aput v15, v14, v5

    const v15, 0x7f080408

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x13

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f5fc

    aput v15, v14, v5

    const v15, 0x7f080409

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x14

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f5fd

    aput v15, v14, v5

    const v15, 0x7f08040a

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x15

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f5fe

    aput v15, v14, v5

    const v15, 0x7f08040b

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x16

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f5ff

    aput v15, v14, v5

    const v15, 0x7f08040c

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x17

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x203c

    aput v15, v14, v5

    const v15, 0x7f08049e

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x18

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2049

    aput v15, v14, v5

    const v15, 0x7f08049f

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x19

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2122

    aput v15, v14, v5

    const v15, 0x7f0804a0

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x1a

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x231a

    aput v15, v14, v5

    const v15, 0x7f0804aa

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x1b

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x231b

    aput v15, v14, v5

    const v15, 0x7f0804ab

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x1c

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x23f0

    aput v15, v14, v5

    const v15, 0x7f0804b0

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x1d

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x23f3

    aput v15, v14, v5

    const v15, 0x7f0804b1

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x1e

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0xa9

    aput v15, v14, v5

    const v15, 0x7f0801d2

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x1f

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0xae

    aput v15, v14, v5

    const v15, 0x7f0801d3

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x20

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f300

    aput v15, v14, v5

    const v15, 0x7f0801fe

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x21

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f302

    aput v15, v14, v5

    const v15, 0x7f080200

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x22

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f30a

    aput v15, v14, v5

    const v15, 0x7f080208

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x23

    aput-object v1, v0, v14

    sput-object v0, Lchat/ola/vn/r/c;->b:[Lchat/ola/vn/entry/h;

    const/16 v0, 0xcd

    new-array v0, v0, [Lchat/ola/vn/entry/h;

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v15, v6, [I

    aput v14, v15, v5

    const v14, 0x7f0801c7

    invoke-direct {v1, v14, v6, v15}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v5

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x30

    aput v15, v14, v5

    const v15, 0x7f0801c8

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v6

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x31

    aput v15, v14, v5

    const v15, 0x7f0801c9

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x32

    aput v15, v14, v5

    const v15, 0x7f0801ca

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v8

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x33

    aput v15, v14, v5

    const v15, 0x7f0801cb

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v3

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x34

    aput v15, v14, v5

    const v15, 0x7f0801cc

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v4

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x35

    aput v15, v14, v5

    const v15, 0x7f0801cd

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v7

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x36

    aput v15, v14, v5

    const v15, 0x7f0801ce

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v9

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x37

    aput v15, v14, v5

    const v15, 0x7f0801cf

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v10

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x38

    aput v15, v14, v5

    const v15, 0x7f0801d0

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v11

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x39

    aput v15, v14, v5

    const v15, 0x7f0801d1

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v12

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2139

    aput v15, v14, v5

    const v15, 0x7f0804a1

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v13

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2194

    aput v15, v14, v5

    const v15, 0x7f0804a2

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xc

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2195

    aput v15, v14, v5

    const v15, 0x7f0804a3

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xd

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2196

    aput v15, v14, v5

    const v15, 0x7f0804a4

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xe

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2197

    aput v15, v14, v5

    const v15, 0x7f0804a5

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xf

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2198

    aput v15, v14, v5

    const v15, 0x7f0804a6

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x10

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2199

    aput v15, v14, v5

    const v15, 0x7f0804a7

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x11

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x21a9

    aput v15, v14, v5

    const v15, 0x7f0804a8

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x12

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x21aa

    aput v15, v14, v5

    const v15, 0x7f0804a9

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x13

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x23e9

    aput v15, v14, v5

    const v15, 0x7f0804ac

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x14

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x23ea

    aput v15, v14, v5

    const v15, 0x7f0804ad

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x15

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x23eb

    aput v15, v14, v5

    const v15, 0x7f0804ae

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x16

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x23ec

    aput v15, v14, v5

    const v15, 0x7f0804af

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x17

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x25b6

    aput v15, v14, v5

    const v15, 0x7f0804b5

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x18

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x25c0

    aput v15, v14, v5

    const v15, 0x7f0804b6

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x19

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2934

    aput v15, v14, v5

    const v15, 0x7f080504

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x1a

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2935

    aput v15, v14, v5

    const v15, 0x7f080505

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x1b

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2b05

    aput v15, v14, v5

    const v15, 0x7f080506

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x1c

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2b06

    aput v15, v14, v5

    const v15, 0x7f080507

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x1d

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2b07

    aput v15, v14, v5

    const v15, 0x7f080508

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x1e

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f500

    aput v15, v14, v5

    const v15, 0x7f0803b3

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x1f

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f501

    aput v15, v14, v5

    const v15, 0x7f0803b4

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x20

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f502

    aput v15, v14, v5

    const v15, 0x7f0803b5

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x21

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f504

    aput v15, v14, v5

    const v15, 0x7f0803b7

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x22

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f53c

    aput v15, v14, v5

    const v15, 0x7f0803ee

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x23

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f53d

    aput v15, v14, v5

    const v15, 0x7f0803ef

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x24

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f192

    aput v15, v14, v5

    const v15, 0x7f0801dc

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x25

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f193

    aput v15, v14, v5

    const v15, 0x7f0801dd

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x26

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f195

    aput v15, v14, v5

    const v15, 0x7f0801df

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x27

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f196

    aput v15, v14, v5

    const v15, 0x7f0801e0

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x28

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f197

    aput v15, v14, v5

    const v15, 0x7f0801e1

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x29

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f199

    aput v15, v14, v5

    const v15, 0x7f0801e3

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x2a

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f170

    aput v15, v14, v5

    const v15, 0x7f0801d6

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x2b

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f171

    aput v15, v14, v5

    const v15, 0x7f0801d7

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x2c

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f17e

    aput v15, v14, v5

    const v15, 0x7f0801d8

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x2d

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f18e

    aput v15, v14, v5

    const v15, 0x7f0801da

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x2e

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f191

    aput v15, v14, v5

    const v15, 0x7f0801db

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x2f

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f198

    aput v15, v14, v5

    const v15, 0x7f0801e2

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x30

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f17f

    aput v15, v14, v5

    const v15, 0x7f0801d9

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x31

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f194

    aput v15, v14, v5

    const v15, 0x7f0801de

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x32

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f004

    aput v15, v14, v5

    const v15, 0x7f0801d4

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x33

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f0cf

    aput v15, v14, v5

    const v15, 0x7f0801d5

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x34

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f19a

    aput v15, v14, v5

    const v15, 0x7f0801e4

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x35

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v2, [I

    fill-array-data v14, :array_0

    const v15, 0x7f0801e6

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x36

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v2, [I

    fill-array-data v14, :array_1

    const v15, 0x7f0801e7

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x37

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v2, [I

    fill-array-data v14, :array_2

    const v15, 0x7f0801e8

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x38

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v2, [I

    fill-array-data v14, :array_3

    const v15, 0x7f0801e9

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x39

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v2, [I

    fill-array-data v14, :array_4

    const v15, 0x7f0801ea

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x3a

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v2, [I

    fill-array-data v14, :array_5

    const v15, 0x7f0801eb

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x3b

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v2, [I

    fill-array-data v14, :array_6

    const v15, 0x7f0801ec

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x3c

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v2, [I

    fill-array-data v14, :array_7

    const v15, 0x7f0801ed

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x3d

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v2, [I

    fill-array-data v14, :array_8

    const v15, 0x7f0801ee

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x3e

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f201

    aput v15, v14, v5

    const v15, 0x7f0801ef

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x3f

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x24c2

    aput v15, v14, v5

    const v15, 0x7f0804b2

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x40

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x25aa

    aput v15, v14, v5

    const v15, 0x7f0804b3

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x41

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x25ab

    aput v15, v14, v5

    const v15, 0x7f0804b4

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x42

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x25fb

    aput v15, v14, v5

    const v15, 0x7f0804b7

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x43

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x25fc

    aput v15, v14, v5

    const v15, 0x7f0804b8

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x44

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x25fd

    aput v15, v14, v5

    const v15, 0x7f0804b9

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x45

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x25fe

    aput v15, v14, v5

    const v15, 0x7f0804ba

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x46

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2600

    aput v15, v14, v5

    const v15, 0x7f0804bb

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x47

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2601

    aput v15, v14, v5

    const v15, 0x7f0804bc

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x48

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x260e

    aput v15, v14, v5

    const v15, 0x7f0804bd

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x49

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2611

    aput v15, v14, v5

    const v15, 0x7f0804be

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x4a

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2614

    aput v15, v14, v5

    const v15, 0x7f0804bf

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x4b

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2615

    aput v15, v14, v5

    const v15, 0x7f0804c0

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x4c

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x261d

    aput v15, v14, v5

    const v15, 0x7f0804c1

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x4d

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2660

    aput v15, v14, v5

    const v15, 0x7f0804cf

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x4e

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2663

    aput v15, v14, v5

    const v15, 0x7f0804d0

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x4f

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2665

    aput v15, v14, v5

    const v15, 0x7f0804d1

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x50

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2666

    aput v15, v14, v5

    const v15, 0x7f0804d2

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x51

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2668

    aput v15, v14, v5

    const v15, 0x7f0804d3

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x52

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x267b

    aput v15, v14, v5

    const v15, 0x7f0804d4

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x53

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2693

    aput v15, v14, v5

    const v15, 0x7f0804d6

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x54

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x26a0

    aput v15, v14, v5

    const v15, 0x7f0804d7

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x55

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x26a1

    aput v15, v14, v5

    const v15, 0x7f0804d8

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x56

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x26aa

    aput v15, v14, v5

    const v15, 0x7f0804d9

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x57

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x26ab

    aput v15, v14, v5

    const v15, 0x7f0804da

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x58

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x26bd

    aput v15, v14, v5

    const v15, 0x7f0804db

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x59

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x26be

    aput v15, v14, v5

    const v15, 0x7f0804dc

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x5a

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x26c5

    aput v15, v14, v5

    const v15, 0x7f0804de

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x5b

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x26d4

    aput v15, v14, v5

    const v15, 0x7f0804e0

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x5c

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x26ea

    aput v15, v14, v5

    const v15, 0x7f0804e1

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x5d

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x26f2

    aput v15, v14, v5

    const v15, 0x7f0804e2

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x5e

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x26f3

    aput v15, v14, v5

    const v15, 0x7f0804e3

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x5f

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x26f5

    aput v15, v14, v5

    const v15, 0x7f0804e4

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x60

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x26fa

    aput v15, v14, v5

    const v15, 0x7f0804e5

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x61

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x26fd

    aput v15, v14, v5

    const v15, 0x7f0804e6

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x62

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2702

    aput v15, v14, v5

    const v15, 0x7f0804e7

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x63

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2705

    aput v15, v14, v5

    const v15, 0x7f0804e8

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x64

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2708

    aput v15, v14, v5

    const v15, 0x7f0804e9

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x65

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2709

    aput v15, v14, v5

    const v15, 0x7f0804ea

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x66

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x270a

    aput v15, v14, v5

    const v15, 0x7f0804eb

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x67

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x270b

    aput v15, v14, v5

    const v15, 0x7f0804ec

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x68

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x270c

    aput v15, v14, v5

    const v15, 0x7f0804ed

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x69

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x270f

    aput v15, v14, v5

    const v15, 0x7f0804ee

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x6a

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2712

    aput v15, v14, v5

    const v15, 0x7f0804ef

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x6b

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2714

    aput v15, v14, v5

    const v15, 0x7f0804f0

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x6c

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2716

    aput v15, v14, v5

    const v15, 0x7f0804f1

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x6d

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2728

    aput v15, v14, v5

    const v15, 0x7f0804f2

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x6e

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2733

    aput v15, v14, v5

    const v15, 0x7f0804f3

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x6f

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2734

    aput v15, v14, v5

    const v15, 0x7f0804f4

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x70

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2744

    aput v15, v14, v5

    const v15, 0x7f0804f5

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x71

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2747

    aput v15, v14, v5

    const v15, 0x7f0804f6

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x72

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x274c

    aput v15, v14, v5

    const v15, 0x7f0804f7

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x73

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x274e

    aput v15, v14, v5

    const v15, 0x7f0804f8

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x74

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2753

    aput v15, v14, v5

    const v15, 0x7f0804f9

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x75

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2754

    aput v15, v14, v5

    const v15, 0x7f0804fa

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x76

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2755

    aput v15, v14, v5

    const v15, 0x7f0804fb

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x77

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2757

    aput v15, v14, v5

    const v15, 0x7f0804fc

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x78

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2764

    aput v15, v14, v5

    const v15, 0x7f0804fd

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x79

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2795

    aput v15, v14, v5

    const v15, 0x7f0804fe

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x7a

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2796

    aput v15, v14, v5

    const v15, 0x7f0804ff

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x7b

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2797

    aput v15, v14, v5

    const v15, 0x7f080500

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x7c

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x27b0

    aput v15, v14, v5

    const v15, 0x7f080502

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x7d

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x27a1

    aput v15, v14, v5

    const v15, 0x7f080501

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x7e

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x27bf

    aput v15, v14, v5

    const v15, 0x7f080503

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x7f

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2b1b

    aput v15, v14, v5

    const v15, 0x7f080509

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x80

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2b1c

    aput v15, v14, v5

    const v15, 0x7f08050a

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x81

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2b50

    aput v15, v14, v5

    const v15, 0x7f08050b

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x82

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2b55

    aput v15, v14, v5

    const v15, 0x7f08050c

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x83

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x3030

    aput v15, v14, v5

    const v15, 0x7f08050d

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x84

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x303d

    aput v15, v14, v5

    const v15, 0x7f08050e

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x85

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x3297

    aput v15, v14, v5

    const v15, 0x7f08050f

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x86

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x3299

    aput v15, v14, v5

    const v15, 0x7f080510

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x87

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2702

    aput v15, v14, v5

    const v15, 0x7f0804e7

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x88

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2705

    aput v15, v14, v5

    const v15, 0x7f0804e8

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x89

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2708

    aput v15, v14, v5

    const v15, 0x7f0804e9

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x8a

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2709

    aput v15, v14, v5

    const v15, 0x7f0804ea

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x8b

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x270a

    aput v15, v14, v5

    const v15, 0x7f0804eb

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x8c

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x270b

    aput v15, v14, v5

    const v15, 0x7f0804ec

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x8d

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x270c

    aput v15, v14, v5

    const v15, 0x7f0804ed

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x8e

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x270f

    aput v15, v14, v5

    const v15, 0x7f0804ee

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x8f

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2712

    aput v15, v14, v5

    const v15, 0x7f0804ef

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x90

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2714

    aput v15, v14, v5

    const v15, 0x7f0804f0

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x91

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2716

    aput v15, v14, v5

    const v15, 0x7f0804f1

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x92

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2728

    aput v15, v14, v5

    const v15, 0x7f0804f2

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x93

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2733

    aput v15, v14, v5

    const v15, 0x7f0804f3

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x94

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2734

    aput v15, v14, v5

    const v15, 0x7f0804f4

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x95

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2744

    aput v15, v14, v5

    const v15, 0x7f0804f5

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x96

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2747

    aput v15, v14, v5

    const v15, 0x7f0804f6

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x97

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x274c

    aput v15, v14, v5

    const v15, 0x7f0804f7

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x98

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x274e

    aput v15, v14, v5

    const v15, 0x7f0804f8

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x99

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2753

    aput v15, v14, v5

    const v15, 0x7f0804f9

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x9a

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2754

    aput v15, v14, v5

    const v15, 0x7f0804fa

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x9b

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2755

    aput v15, v14, v5

    const v15, 0x7f0804fb

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x9c

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2757

    aput v15, v14, v5

    const v15, 0x7f0804fc

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x9d

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2764

    aput v15, v14, v5

    const v15, 0x7f0804fd

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x9e

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2795

    aput v15, v14, v5

    const v15, 0x7f0804fe

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x9f

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2796

    aput v15, v14, v5

    const v15, 0x7f0804ff

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xa0

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2797

    aput v15, v14, v5

    const v15, 0x7f080500

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xa1

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x27a1

    aput v15, v14, v5

    const v15, 0x7f080501

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xa2

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x27b0

    aput v15, v14, v5

    const v15, 0x7f080502

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xa3

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f51d

    aput v15, v14, v5

    const v15, 0x7f0803cf

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xa4

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f51f

    aput v15, v14, v5

    const v15, 0x7f0803d1

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xa5

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f520

    aput v15, v14, v5

    const v15, 0x7f0803d2

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xa6

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f521

    aput v15, v14, v5

    const v15, 0x7f0803d3

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xa7

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f522

    aput v15, v14, v5

    const v15, 0x7f0803d4

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xa8

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f523

    aput v15, v14, v5

    const v15, 0x7f0803d5

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xa9

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f524

    aput v15, v14, v5

    const v15, 0x7f0803d6

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xaa

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f4f3

    aput v15, v14, v5

    const v15, 0x7f0803aa

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xab

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f4f4

    aput v15, v14, v5

    const v15, 0x7f0803ab

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xac

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f4f6

    aput v15, v14, v5

    const v15, 0x7f0803ad

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xad

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f49f

    aput v15, v14, v5

    const v15, 0x7f080356

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xae

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f3a6

    aput v15, v14, v5

    const v15, 0x7f080284

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xaf

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f21a

    aput v15, v14, v5

    const v15, 0x7f0801f1

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xb0

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f22f

    aput v15, v14, v5

    const v15, 0x7f0801f2

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xb1

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f232

    aput v15, v14, v5

    const v15, 0x7f0801f3

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xb2

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f234

    aput v15, v14, v5

    const v15, 0x7f0801f5

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xb3

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f235

    aput v15, v14, v5

    const v15, 0x7f0801f6

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xb4

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f236

    aput v15, v14, v5

    const v15, 0x7f0801f7

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xb5

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f237

    aput v15, v14, v5

    const v15, 0x7f0801f8

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xb6

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f238

    aput v15, v14, v5

    const v15, 0x7f0801f9

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xb7

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f239

    aput v15, v14, v5

    const v15, 0x7f0801fa

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xb8

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f23a

    aput v15, v14, v5

    const v15, 0x7f0801fb

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xb9

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f250

    aput v15, v14, v5

    const v15, 0x7f0801fc

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xba

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f251

    aput v15, v14, v5

    const v15, 0x7f0801fd

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xbb

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x267f

    aput v15, v14, v5

    const v15, 0x7f0804d5

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xbc

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2648

    aput v15, v14, v5

    const v15, 0x7f0804c3

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xbd

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2649

    aput v15, v14, v5

    const v15, 0x7f0804c4

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xbe

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x264a

    aput v15, v14, v5

    const v15, 0x7f0804c5

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xbf

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x264b

    aput v15, v14, v5

    const v15, 0x7f0804c6

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xc0

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x264c

    aput v15, v14, v5

    const v15, 0x7f0804c7

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xc1

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x264d

    aput v15, v14, v5

    const v15, 0x7f0804c8

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xc2

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x264e

    aput v15, v14, v5

    const v15, 0x7f0804c9

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xc3

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x264f

    aput v15, v14, v5

    const v15, 0x7f0804ca

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xc4

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2650

    aput v15, v14, v5

    const v15, 0x7f0804cb

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xc5

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2651

    aput v15, v14, v5

    const v15, 0x7f0804cc

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xc6

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2652

    aput v15, v14, v5

    const v15, 0x7f0804cd

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xc7

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x2653

    aput v15, v14, v5

    const v15, 0x7f0804ce

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xc8

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f52f

    aput v15, v14, v5

    const v15, 0x7f0803e1

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xc9

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x26ce

    aput v15, v14, v5

    const v15, 0x7f0804df

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xca

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f233

    aput v15, v14, v5

    const v15, 0x7f0801f4

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xcb

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f202

    aput v15, v14, v5

    const v15, 0x7f0801f0

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xcc

    aput-object v1, v0, v14

    sput-object v0, Lchat/ola/vn/r/c;->c:[Lchat/ola/vn/entry/h;

    const/16 v0, 0x5f

    new-array v0, v0, [Lchat/ola/vn/entry/h;

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f600

    aput v15, v14, v5

    const v15, 0x7f08040d

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v5

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f601

    aput v15, v14, v5

    const v15, 0x7f08040e

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v6

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f602

    aput v15, v14, v5

    const v15, 0x7f08040f

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f603

    aput v15, v14, v5

    const v15, 0x7f080410

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v8

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f604

    aput v15, v14, v5

    const v15, 0x7f080411

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v3

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f605

    aput v15, v14, v5

    const v15, 0x7f080412

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v4

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f606

    aput v15, v14, v5

    const v15, 0x7f080413

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v7

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f607

    aput v15, v14, v5

    const v15, 0x7f080414

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v9

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f608

    aput v15, v14, v5

    const v15, 0x7f080415

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v10

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f609

    aput v15, v14, v5

    const v15, 0x7f080416

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v11

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f60a

    aput v15, v14, v5

    const v15, 0x7f080417

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v12

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f60b

    aput v15, v14, v5

    const v15, 0x7f080418

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v13

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f60c

    aput v15, v14, v5

    const v15, 0x7f080419

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xc

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f60d

    aput v15, v14, v5

    const v15, 0x7f08041a

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xd

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f60e

    aput v15, v14, v5

    const v15, 0x7f08041b

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xe

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f60f

    aput v15, v14, v5

    const v15, 0x7f08041c

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0xf

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f610

    aput v15, v14, v5

    const v15, 0x7f08041d

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x10

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f611

    aput v15, v14, v5

    const v15, 0x7f08041e

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x11

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f612

    aput v15, v14, v5

    const v15, 0x7f08041f

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x12

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f613

    aput v15, v14, v5

    const v15, 0x7f080420

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x13

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f614

    aput v15, v14, v5

    const v15, 0x7f080421

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x14

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f615

    aput v15, v14, v5

    const v15, 0x7f080422

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x15

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f616

    aput v15, v14, v5

    const v15, 0x7f080423

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x16

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f617

    aput v15, v14, v5

    const v15, 0x7f080424

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x17

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f618

    aput v15, v14, v5

    const v15, 0x7f080425

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x18

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f619

    aput v15, v14, v5

    const v15, 0x7f080426

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x19

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f61a

    aput v15, v14, v5

    const v15, 0x7f080427

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x1a

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f61b

    aput v15, v14, v5

    const v15, 0x7f080428

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x1b

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f61c

    aput v15, v14, v5

    const v15, 0x7f080429

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x1c

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f61d

    aput v15, v14, v5

    const v15, 0x7f08042a

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x1d

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f61e

    aput v15, v14, v5

    const v15, 0x7f08042b

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x1e

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f61f

    aput v15, v14, v5

    const v15, 0x7f08042c

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x1f

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f620

    aput v15, v14, v5

    const v15, 0x7f08042d

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x20

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f621

    aput v15, v14, v5

    const v15, 0x7f08042e

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x21

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f622

    aput v15, v14, v5

    const v15, 0x7f08042f

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x22

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f623

    aput v15, v14, v5

    const v15, 0x7f080430

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x23

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f624

    aput v15, v14, v5

    const v15, 0x7f080431

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x24

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f625

    aput v15, v14, v5

    const v15, 0x7f080432

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x25

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f626

    aput v15, v14, v5

    const v15, 0x7f080433

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x26

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f627

    aput v15, v14, v5

    const v15, 0x7f080434

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x27

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f628

    aput v15, v14, v5

    const v15, 0x7f080435

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x28

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f629

    aput v15, v14, v5

    const v15, 0x7f080436

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x29

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f62a

    aput v15, v14, v5

    const v15, 0x7f080437

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x2a

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f62b

    aput v15, v14, v5

    const v15, 0x7f080438

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x2b

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f62c

    aput v15, v14, v5

    const v15, 0x7f080439

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x2c

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f62d

    aput v15, v14, v5

    const v15, 0x7f08043a

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x2d

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f62e

    aput v15, v14, v5

    const v15, 0x7f08043b

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x2e

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f62f

    aput v15, v14, v5

    const v15, 0x7f08043c

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x2f

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f630

    aput v15, v14, v5

    const v15, 0x7f08043d

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x30

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f631

    aput v15, v14, v5

    const v15, 0x7f08043e

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x31

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f632

    aput v15, v14, v5

    const v15, 0x7f08043f

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x32

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f633

    aput v15, v14, v5

    const v15, 0x7f080440

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x33

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f634

    aput v15, v14, v5

    const v15, 0x7f080441

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x34

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f635

    aput v15, v14, v5

    const v15, 0x7f080442

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x35

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f636

    aput v15, v14, v5

    const v15, 0x7f080443

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x36

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x263a

    aput v15, v14, v5

    const v15, 0x7f0804c2

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x37

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const/16 v15, 0x26c4

    aput v15, v14, v5

    const v15, 0x7f0804dd

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x38

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f31a

    aput v15, v14, v5

    const v15, 0x7f080218

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x39

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f31c

    aput v15, v14, v5

    const v15, 0x7f08021a

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x3a

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f31d

    aput v15, v14, v5

    const v15, 0x7f08021b

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x3b

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f31e

    aput v15, v14, v5

    const v15, 0x7f08021c

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x3c

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f4a9

    aput v15, v14, v5

    const v15, 0x7f080360

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x3d

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f487

    aput v15, v14, v5

    const v15, 0x7f08033e

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x3e

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f486

    aput v15, v14, v5

    const v15, 0x7f08033d

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x3f

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f482

    aput v15, v14, v5

    const v15, 0x7f080339

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x40

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f481

    aput v15, v14, v5

    const v15, 0x7f080338

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x41

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f480

    aput v15, v14, v5

    const v15, 0x7f080337

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x42

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f465

    aput v15, v14, v5

    const v15, 0x7f08031c

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x43

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f466

    aput v15, v14, v5

    const v15, 0x7f08031d

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x44

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f467

    aput v15, v14, v5

    const v15, 0x7f08031e

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x45

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f468

    aput v15, v14, v5

    const v15, 0x7f08031f

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x46

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f469

    aput v15, v14, v5

    const v15, 0x7f080320

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x47

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f46a

    aput v15, v14, v5

    const v15, 0x7f080321

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x48

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f46b

    aput v15, v14, v5

    const v15, 0x7f080322

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x49

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f46c

    aput v15, v14, v5

    const v15, 0x7f080323

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x4a

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f46d

    aput v15, v14, v5

    const v15, 0x7f080324

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x4b

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f46e

    aput v15, v14, v5

    const v15, 0x7f080325

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x4c

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f46f

    aput v15, v14, v5

    const v15, 0x7f080326

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x4d

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f470

    aput v15, v14, v5

    const v15, 0x7f080327

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x4e

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f471

    aput v15, v14, v5

    const v15, 0x7f080328

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x4f

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f472

    aput v15, v14, v5

    const v15, 0x7f080329

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x50

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f473

    aput v15, v14, v5

    const v15, 0x7f08032a

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x51

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f474

    aput v15, v14, v5

    const v15, 0x7f08032b

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x52

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f475

    aput v15, v14, v5

    const v15, 0x7f08032c

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x53

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f476

    aput v15, v14, v5

    const v15, 0x7f08032d

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x54

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f477

    aput v15, v14, v5

    const v15, 0x7f08032e

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x55

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f478

    aput v15, v14, v5

    const v15, 0x7f08032f

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x56

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f479

    aput v15, v14, v5

    const v15, 0x7f080330

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x57

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f47a

    aput v15, v14, v5

    const v15, 0x7f080331

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x58

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f47b

    aput v15, v14, v5

    const v15, 0x7f080332

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x59

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f47c

    aput v15, v14, v5

    const v15, 0x7f080333

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x5a

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f47d

    aput v15, v14, v5

    const v15, 0x7f080334

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x5b

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f47e

    aput v15, v14, v5

    const v15, 0x7f080335

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x5c

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f47f

    aput v15, v14, v5

    const v15, 0x7f080336

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x5d

    aput-object v1, v0, v14

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f43c

    aput v15, v14, v5

    const v15, 0x7f0802f5

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v14, 0x5e

    aput-object v1, v0, v14

    sput-object v0, Lchat/ola/vn/r/c;->d:[Lchat/ola/vn/entry/h;

    const/16 v0, 0x1bb

    new-array v0, v0, [Lchat/ola/vn/entry/h;

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f30d

    aput v15, v14, v5

    const v15, 0x7f08020b

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v5

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f30e

    aput v15, v14, v5

    const v15, 0x7f08020c

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v6

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v14, v6, [I

    const v15, 0x1f30f

    aput v15, v14, v5

    const v15, 0x7f08020d

    invoke-direct {v1, v15, v6, v14}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v14, 0x1f310

    aput v14, v2, v5

    const v14, 0x7f08020e

    invoke-direct {v1, v14, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v8

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v8, 0x1f311

    aput v8, v2, v5

    const v8, 0x7f08020f

    invoke-direct {v1, v8, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v3

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f312

    aput v3, v2, v5

    const v3, 0x7f080210

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v4

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f313

    aput v3, v2, v5

    const v3, 0x7f080211

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v7

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f314

    aput v3, v2, v5

    const v3, 0x7f080212

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v9

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f315

    aput v3, v2, v5

    const v3, 0x7f080213

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v10

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f316

    aput v3, v2, v5

    const v3, 0x7f080214

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v11

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f317

    aput v3, v2, v5

    const v3, 0x7f080215

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v12

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f318

    aput v3, v2, v5

    const v3, 0x7f080216

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    aput-object v1, v0, v13

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f319

    aput v3, v2, v5

    const v3, 0x7f080217

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xc

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f31b

    aput v3, v2, v5

    const v3, 0x7f080219

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xd

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f31f

    aput v3, v2, v5

    const v3, 0x7f08021d

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xe

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f330

    aput v3, v2, v5

    const v3, 0x7f08021e

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xf

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f331

    aput v3, v2, v5

    const v3, 0x7f08021f

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x10

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f332

    aput v3, v2, v5

    const v3, 0x7f080220

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x11

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f333

    aput v3, v2, v5

    const v3, 0x7f080221

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x12

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f334

    aput v3, v2, v5

    const v3, 0x7f080222

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x13

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f335

    aput v3, v2, v5

    const v3, 0x7f080223

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x14

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f337

    aput v3, v2, v5

    const v3, 0x7f080224

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x15

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f338

    aput v3, v2, v5

    const v3, 0x7f080225

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x16

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f339

    aput v3, v2, v5

    const v3, 0x7f080226

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x17

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f33a

    aput v3, v2, v5

    const v3, 0x7f080227

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x18

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f33b

    aput v3, v2, v5

    const v3, 0x7f080228

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x19

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f33c

    aput v3, v2, v5

    const v3, 0x7f080229

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x1a

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f33d

    aput v3, v2, v5

    const v3, 0x7f08022a

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x1b

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f33e

    aput v3, v2, v5

    const v3, 0x7f08022b

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x1c

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f33f

    aput v3, v2, v5

    const v3, 0x7f08022c

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x1d

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f340

    aput v3, v2, v5

    const v3, 0x7f08022d

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x1e

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f341

    aput v3, v2, v5

    const v3, 0x7f08022e

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x1f

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f342

    aput v3, v2, v5

    const v3, 0x7f08022f

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x20

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f343

    aput v3, v2, v5

    const v3, 0x7f080230

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x21

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f344

    aput v3, v2, v5

    const v3, 0x7f080231

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x22

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f345

    aput v3, v2, v5

    const v3, 0x7f080232

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x23

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f346

    aput v3, v2, v5

    const v3, 0x7f080233

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x24

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f347

    aput v3, v2, v5

    const v3, 0x7f080234

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x25

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f348

    aput v3, v2, v5

    const v3, 0x7f080235

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x26

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f349

    aput v3, v2, v5

    const v3, 0x7f080236

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x27

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f34a

    aput v3, v2, v5

    const v3, 0x7f080237

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x28

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f34b

    aput v3, v2, v5

    const v3, 0x7f080238

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x29

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f34c

    aput v3, v2, v5

    const v3, 0x7f080239

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x2a

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f34d

    aput v3, v2, v5

    const v3, 0x7f08023a

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x2b

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f34e

    aput v3, v2, v5

    const v3, 0x7f08023b

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x2c

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f34f

    aput v3, v2, v5

    const v3, 0x7f08023c

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x2d

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f350

    aput v3, v2, v5

    const v3, 0x7f08023d

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x2e

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f351

    aput v3, v2, v5

    const v3, 0x7f08023e

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x2f

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f352

    aput v3, v2, v5

    const v3, 0x7f08023f

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x30

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f353

    aput v3, v2, v5

    const v3, 0x7f080240

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x31

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f354

    aput v3, v2, v5

    const v3, 0x7f080241

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x32

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f355

    aput v3, v2, v5

    const v3, 0x7f080242

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x33

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f356

    aput v3, v2, v5

    const v3, 0x7f080243

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x34

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f357

    aput v3, v2, v5

    const v3, 0x7f080244

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x35

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f358

    aput v3, v2, v5

    const v3, 0x7f080245

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x36

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f359

    aput v3, v2, v5

    const v3, 0x7f080246

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x37

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f35a

    aput v3, v2, v5

    const v3, 0x7f080247

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x38

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f35b

    aput v3, v2, v5

    const v3, 0x7f080248

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x39

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f35c

    aput v3, v2, v5

    const v3, 0x7f080249

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x3a

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f35d

    aput v3, v2, v5

    const v3, 0x7f08024a

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x3b

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f35e

    aput v3, v2, v5

    const v3, 0x7f08024b

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x3c

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f35f

    aput v3, v2, v5

    const v3, 0x7f08024c

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x3d

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f360

    aput v3, v2, v5

    const v3, 0x7f08024d

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x3e

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f361

    aput v3, v2, v5

    const v3, 0x7f08024e

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x3f

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f362

    aput v3, v2, v5

    const v3, 0x7f08024f

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x40

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f363

    aput v3, v2, v5

    const v3, 0x7f080250

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x41

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f364

    aput v3, v2, v5

    const v3, 0x7f080251

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x42

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f365

    aput v3, v2, v5

    const v3, 0x7f080252

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x43

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f366

    aput v3, v2, v5

    const v3, 0x7f080253

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x44

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f367

    aput v3, v2, v5

    const v3, 0x7f080254

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x45

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f368

    aput v3, v2, v5

    const v3, 0x7f080255

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x46

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f369

    aput v3, v2, v5

    const v3, 0x7f080256

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x47

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f36a

    aput v3, v2, v5

    const v3, 0x7f080257

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x48

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f36b

    aput v3, v2, v5

    const v3, 0x7f080258

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x49

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f36c

    aput v3, v2, v5

    const v3, 0x7f080259

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x4a

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f36d

    aput v3, v2, v5

    const v3, 0x7f08025a

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x4b

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f36e

    aput v3, v2, v5

    const v3, 0x7f08025b

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x4c

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f36f

    aput v3, v2, v5

    const v3, 0x7f08025c

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x4d

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f370

    aput v3, v2, v5

    const v3, 0x7f08025d

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x4e

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f371

    aput v3, v2, v5

    const v3, 0x7f08025e

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x4f

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f372

    aput v3, v2, v5

    const v3, 0x7f08025f

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x50

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f373

    aput v3, v2, v5

    const v3, 0x7f080260

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x51

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f374

    aput v3, v2, v5

    const v3, 0x7f080261

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x52

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f375

    aput v3, v2, v5

    const v3, 0x7f080262

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x53

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f376

    aput v3, v2, v5

    const v3, 0x7f080263

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x54

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f377

    aput v3, v2, v5

    const v3, 0x7f080264

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x55

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f378

    aput v3, v2, v5

    const v3, 0x7f080265

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x56

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f379

    aput v3, v2, v5

    const v3, 0x7f080266

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x57

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f37a

    aput v3, v2, v5

    const v3, 0x7f080267

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x58

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f37b

    aput v3, v2, v5

    const v3, 0x7f080268

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x59

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f37c

    aput v3, v2, v5

    const v3, 0x7f080269

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x5a

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f380

    aput v3, v2, v5

    const v3, 0x7f08026a

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x5b

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f381

    aput v3, v2, v5

    const v3, 0x7f08026b

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x5c

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f382

    aput v3, v2, v5

    const v3, 0x7f08026c

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x5d

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f383

    aput v3, v2, v5

    const v3, 0x7f08026d

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x5e

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f384

    aput v3, v2, v5

    const v3, 0x7f08026e

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x5f

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f385

    aput v3, v2, v5

    const v3, 0x7f08026f

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x60

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f388

    aput v3, v2, v5

    const v3, 0x7f080272

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x61

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f389

    aput v3, v2, v5

    const v3, 0x7f080273

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x62

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f38a

    aput v3, v2, v5

    const v3, 0x7f080274

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x63

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f38b

    aput v3, v2, v5

    const v3, 0x7f080275

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x64

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f38c

    aput v3, v2, v5

    const v3, 0x7f080276

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x65

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f38d

    aput v3, v2, v5

    const v3, 0x7f080277

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x66

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f38e

    aput v3, v2, v5

    const v3, 0x7f080278

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x67

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f38f

    aput v3, v2, v5

    const v3, 0x7f080279

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x68

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f390

    aput v3, v2, v5

    const v3, 0x7f08027a

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x69

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f392

    aput v3, v2, v5

    const v3, 0x7f08027c

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x6a

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f393

    aput v3, v2, v5

    const v3, 0x7f08027d

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x6b

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3a3

    aput v3, v2, v5

    const v3, 0x7f080281

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x6c

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3a4

    aput v3, v2, v5

    const v3, 0x7f080282

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x6d

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3a5

    aput v3, v2, v5

    const v3, 0x7f080283

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x6e

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3a7

    aput v3, v2, v5

    const v3, 0x7f080285

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x6f

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3a8

    aput v3, v2, v5

    const v3, 0x7f080286

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x70

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3a9

    aput v3, v2, v5

    const v3, 0x7f080287

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x71

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3aa

    aput v3, v2, v5

    const v3, 0x7f080288

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x72

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3ab

    aput v3, v2, v5

    const v3, 0x7f080289

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x73

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3ac

    aput v3, v2, v5

    const v3, 0x7f08028a

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x74

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3ad

    aput v3, v2, v5

    const v3, 0x7f08028b

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x75

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3ae

    aput v3, v2, v5

    const v3, 0x7f08028c

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x76

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3af

    aput v3, v2, v5

    const v3, 0x7f08028d

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x77

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3b0

    aput v3, v2, v5

    const v3, 0x7f08028e

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x78

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3b1

    aput v3, v2, v5

    const v3, 0x7f08028f

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x79

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3b2

    aput v3, v2, v5

    const v3, 0x7f080290

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x7a

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3b3

    aput v3, v2, v5

    const v3, 0x7f080291

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x7b

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3b4

    aput v3, v2, v5

    const v3, 0x7f080292

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x7c

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3b5

    aput v3, v2, v5

    const v3, 0x7f080293

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x7d

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3b6

    aput v3, v2, v5

    const v3, 0x7f080294

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x7e

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3b7

    aput v3, v2, v5

    const v3, 0x7f080295

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x7f

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3b8

    aput v3, v2, v5

    const v3, 0x7f080296

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x80

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3b9

    aput v3, v2, v5

    const v3, 0x7f080297

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x81

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3ba

    aput v3, v2, v5

    const v3, 0x7f080298

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x82

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3bb

    aput v3, v2, v5

    const v3, 0x7f080299

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x83

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3bc

    aput v3, v2, v5

    const v3, 0x7f08029a

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x84

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3bd

    aput v3, v2, v5

    const v3, 0x7f08029b

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x85

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3be

    aput v3, v2, v5

    const v3, 0x7f08029c

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x86

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3bf

    aput v3, v2, v5

    const v3, 0x7f08029d

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x87

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3c0

    aput v3, v2, v5

    const v3, 0x7f08029e

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x88

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3c1

    aput v3, v2, v5

    const v3, 0x7f08029f

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x89

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3c2

    aput v3, v2, v5

    const v3, 0x7f0802a0

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x8a

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3c3

    aput v3, v2, v5

    const v3, 0x7f0802a1

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x8b

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3c4

    aput v3, v2, v5

    const v3, 0x7f0802a2

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x8c

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3c6

    aput v3, v2, v5

    const v3, 0x7f0802a3

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x8d

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3c7

    aput v3, v2, v5

    const v3, 0x7f0802a4

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x8e

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3c8

    aput v3, v2, v5

    const v3, 0x7f0802a5

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x8f

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3c9

    aput v3, v2, v5

    const v3, 0x7f0802a6

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x90

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3ca

    aput v3, v2, v5

    const v3, 0x7f0802a7

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x91

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3e0

    aput v3, v2, v5

    const v3, 0x7f0802a8

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x92

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3e1

    aput v3, v2, v5

    const v3, 0x7f0802a9

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x93

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3e2

    aput v3, v2, v5

    const v3, 0x7f0802aa

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x94

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3e3

    aput v3, v2, v5

    const v3, 0x7f0802ab

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x95

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3e4

    aput v3, v2, v5

    const v3, 0x7f0802ac

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x96

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3e5

    aput v3, v2, v5

    const v3, 0x7f0802ad

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x97

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3e6

    aput v3, v2, v5

    const v3, 0x7f0802ae

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x98

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3e7

    aput v3, v2, v5

    const v3, 0x7f0802af

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x99

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3e8

    aput v3, v2, v5

    const v3, 0x7f0802b0

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x9a

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3e9

    aput v3, v2, v5

    const v3, 0x7f0802b1

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x9b

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3ea

    aput v3, v2, v5

    const v3, 0x7f0802b2

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x9c

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3eb

    aput v3, v2, v5

    const v3, 0x7f0802b3

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x9d

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3ec

    aput v3, v2, v5

    const v3, 0x7f0802b4

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x9e

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f3ee

    aput v3, v2, v5

    const v3, 0x7f0802b6

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x9f

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f400

    aput v3, v2, v5

    const v3, 0x7f0802b9

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xa0

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f401

    aput v3, v2, v5

    const v3, 0x7f0802ba

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xa1

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f402

    aput v3, v2, v5

    const v3, 0x7f0802bb

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xa2

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f403

    aput v3, v2, v5

    const v3, 0x7f0802bc

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xa3

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f404

    aput v3, v2, v5

    const v3, 0x7f0802bd

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xa4

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f405

    aput v3, v2, v5

    const v3, 0x7f0802be

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xa5

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f406

    aput v3, v2, v5

    const v3, 0x7f0802bf

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xa6

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f407

    aput v3, v2, v5

    const v3, 0x7f0802c0

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xa7

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f408

    aput v3, v2, v5

    const v3, 0x7f0802c1

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xa8

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f409

    aput v3, v2, v5

    const v3, 0x7f0802c2

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xa9

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f40a

    aput v3, v2, v5

    const v3, 0x7f0802c3

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xaa

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f40b

    aput v3, v2, v5

    const v3, 0x7f0802c4

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xab

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f40c

    aput v3, v2, v5

    const v3, 0x7f0802c5

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xac

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f40d

    aput v3, v2, v5

    const v3, 0x7f0802c6

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xad

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f40e

    aput v3, v2, v5

    const v3, 0x7f0802c7

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xae

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f40f

    aput v3, v2, v5

    const v3, 0x7f0802c8

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xaf

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f410

    aput v3, v2, v5

    const v3, 0x7f0802c9

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xb0

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f411

    aput v3, v2, v5

    const v3, 0x7f0802ca

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xb1

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f412

    aput v3, v2, v5

    const v3, 0x7f0802cb

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xb2

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f413

    aput v3, v2, v5

    const v3, 0x7f0802cc

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xb3

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f414

    aput v3, v2, v5

    const v3, 0x7f0802cd

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xb4

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f415

    aput v3, v2, v5

    const v3, 0x7f0802ce

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xb5

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f416

    aput v3, v2, v5

    const v3, 0x7f0802cf

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xb6

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f417

    aput v3, v2, v5

    const v3, 0x7f0802d0

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xb7

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f418

    aput v3, v2, v5

    const v3, 0x7f0802d1

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xb8

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f419

    aput v3, v2, v5

    const v3, 0x7f0802d2

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xb9

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f41a

    aput v3, v2, v5

    const v3, 0x7f0802d3

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xba

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f41b

    aput v3, v2, v5

    const v3, 0x7f0802d4

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xbb

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f41c

    aput v3, v2, v5

    const v3, 0x7f0802d5

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xbc

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f41d

    aput v3, v2, v5

    const v3, 0x7f0802d6

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xbd

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f41e

    aput v3, v2, v5

    const v3, 0x7f0802d7

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xbe

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f41f

    aput v3, v2, v5

    const v3, 0x7f0802d8

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xbf

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f420

    aput v3, v2, v5

    const v3, 0x7f0802d9

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xc0

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f421

    aput v3, v2, v5

    const v3, 0x7f0802da

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xc1

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f422

    aput v3, v2, v5

    const v3, 0x7f0802db

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xc2

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f423

    aput v3, v2, v5

    const v3, 0x7f0802dc

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xc3

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f424

    aput v3, v2, v5

    const v3, 0x7f0802dd

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xc4

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f425

    aput v3, v2, v5

    const v3, 0x7f0802de

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xc5

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f426

    aput v3, v2, v5

    const v3, 0x7f0802df

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xc6

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f427

    aput v3, v2, v5

    const v3, 0x7f0802e0

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xc7

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f428

    aput v3, v2, v5

    const v3, 0x7f0802e1

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xc8

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f429

    aput v3, v2, v5

    const v3, 0x7f0802e2

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xc9

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f42a

    aput v3, v2, v5

    const v3, 0x7f0802e3

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xca

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f42b

    aput v3, v2, v5

    const v3, 0x7f0802e4

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xcb

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f42c

    aput v3, v2, v5

    const v3, 0x7f0802e5

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xcc

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f42d

    aput v3, v2, v5

    const v3, 0x7f0802e6

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xcd

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f42e

    aput v3, v2, v5

    const v3, 0x7f0802e7

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xce

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f42f

    aput v3, v2, v5

    const v3, 0x7f0802e8

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xcf

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f430

    aput v3, v2, v5

    const v3, 0x7f0802e9

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xd0

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f431

    aput v3, v2, v5

    const v3, 0x7f0802ea

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xd1

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f432

    aput v3, v2, v5

    const v3, 0x7f0802eb

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xd2

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f433

    aput v3, v2, v5

    const v3, 0x7f0802ec

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xd3

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f434

    aput v3, v2, v5

    const v3, 0x7f0802ed

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xd4

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f435

    aput v3, v2, v5

    const v3, 0x7f0802ee

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xd5

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f436

    aput v3, v2, v5

    const v3, 0x7f0802ef

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xd6

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f437

    aput v3, v2, v5

    const v3, 0x7f0802f0

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xd7

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f438

    aput v3, v2, v5

    const v3, 0x7f0802f1

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xd8

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f439

    aput v3, v2, v5

    const v3, 0x7f0802f2

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xd9

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f43a

    aput v3, v2, v5

    const v3, 0x7f0802f3

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xda

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f43b

    aput v3, v2, v5

    const v3, 0x7f0802f4

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xdb

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f43d

    aput v3, v2, v5

    const v3, 0x7f0802f6

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xdc

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f43e

    aput v3, v2, v5

    const v3, 0x7f0802f7

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xdd

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f440

    aput v3, v2, v5

    const v3, 0x7f0802f8

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xde

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f442

    aput v3, v2, v5

    const v3, 0x7f0802f9

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xdf

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f443

    aput v3, v2, v5

    const v3, 0x7f0802fa

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xe0

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f444

    aput v3, v2, v5

    const v3, 0x7f0802fb

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xe1

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f445

    aput v3, v2, v5

    const v3, 0x7f0802fc

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xe2

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f446

    aput v3, v2, v5

    const v3, 0x7f0802fd

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xe3

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f447

    aput v3, v2, v5

    const v3, 0x7f0802fe

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xe4

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f448

    aput v3, v2, v5

    const v3, 0x7f0802ff

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xe5

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f449

    aput v3, v2, v5

    const v3, 0x7f080300

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xe6

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f44a

    aput v3, v2, v5

    const v3, 0x7f080301

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xe7

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f44b

    aput v3, v2, v5

    const v3, 0x7f080302

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xe8

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f44c

    aput v3, v2, v5

    const v3, 0x7f080303

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xe9

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f44d

    aput v3, v2, v5

    const v3, 0x7f080304

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xea

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f44e

    aput v3, v2, v5

    const v3, 0x7f080305

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xeb

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f44f

    aput v3, v2, v5

    const v3, 0x7f080306

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xec

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f450

    aput v3, v2, v5

    const v3, 0x7f080307

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xed

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f451

    aput v3, v2, v5

    const v3, 0x7f080308

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xee

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f452

    aput v3, v2, v5

    const v3, 0x7f080309

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xef

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f453

    aput v3, v2, v5

    const v3, 0x7f08030a

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xf0

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f454

    aput v3, v2, v5

    const v3, 0x7f08030b

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xf1

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f455

    aput v3, v2, v5

    const v3, 0x7f08030c

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xf2

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f456

    aput v3, v2, v5

    const v3, 0x7f08030d

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xf3

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f457

    aput v3, v2, v5

    const v3, 0x7f08030e

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xf4

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f458

    aput v3, v2, v5

    const v3, 0x7f08030f

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xf5

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f459

    aput v3, v2, v5

    const v3, 0x7f080310

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xf6

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f45a

    aput v3, v2, v5

    const v3, 0x7f080311

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xf7

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f45b

    aput v3, v2, v5

    const v3, 0x7f080312

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xf8

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f45c

    aput v3, v2, v5

    const v3, 0x7f080313

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xf9

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f45d

    aput v3, v2, v5

    const v3, 0x7f080314

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xfa

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f45e

    aput v3, v2, v5

    const v3, 0x7f080315

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xfb

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f45f

    aput v3, v2, v5

    const v3, 0x7f080316

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xfc

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f460

    aput v3, v2, v5

    const v3, 0x7f080317

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xfd

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f461

    aput v3, v2, v5

    const v3, 0x7f080318

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xfe

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f462

    aput v3, v2, v5

    const v3, 0x7f080319

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0xff

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f463

    aput v3, v2, v5

    const v3, 0x7f08031a

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x100

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f464

    aput v3, v2, v5

    const v3, 0x7f08031b

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x101

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f483

    aput v3, v2, v5

    const v3, 0x7f08033a

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x102

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f484

    aput v3, v2, v5

    const v3, 0x7f08033b

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x103

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f485

    aput v3, v2, v5

    const v3, 0x7f08033c

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x104

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f488

    aput v3, v2, v5

    const v3, 0x7f08033f

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x105

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f489

    aput v3, v2, v5

    const v3, 0x7f080340

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x106

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f48a

    aput v3, v2, v5

    const v3, 0x7f080341

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x107

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f48b

    aput v3, v2, v5

    const v3, 0x7f080342

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x108

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f48c

    aput v3, v2, v5

    const v3, 0x7f080343

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x109

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f48d

    aput v3, v2, v5

    const v3, 0x7f080344

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x10a

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f48e

    aput v3, v2, v5

    const v3, 0x7f080345

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x10b

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f48f

    aput v3, v2, v5

    const v3, 0x7f080346

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x10c

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f490

    aput v3, v2, v5

    const v3, 0x7f080347

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x10d

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f491

    aput v3, v2, v5

    const v3, 0x7f080348

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x10e

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f492

    aput v3, v2, v5

    const v3, 0x7f080349

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x10f

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f493

    aput v3, v2, v5

    const v3, 0x7f08034a

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x110

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f494

    aput v3, v2, v5

    const v3, 0x7f08034b

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x111

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f495

    aput v3, v2, v5

    const v3, 0x7f08034c

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x112

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f496

    aput v3, v2, v5

    const v3, 0x7f08034d

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x113

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f497

    aput v3, v2, v5

    const v3, 0x7f08034e

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x114

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f498

    aput v3, v2, v5

    const v3, 0x7f08034f

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x115

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f499

    aput v3, v2, v5

    const v3, 0x7f080350

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x116

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f49a

    aput v3, v2, v5

    const v3, 0x7f080351

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x117

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f49b

    aput v3, v2, v5

    const v3, 0x7f080352

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x118

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f49c

    aput v3, v2, v5

    const v3, 0x7f080353

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x119

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f49d

    aput v3, v2, v5

    const v3, 0x7f080354

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x11a

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f49e

    aput v3, v2, v5

    const v3, 0x7f080355

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x11b

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4a0

    aput v3, v2, v5

    const v3, 0x7f080357

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x11c

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4a1

    aput v3, v2, v5

    const v3, 0x7f080358

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x11d

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4a2

    aput v3, v2, v5

    const v3, 0x7f080359

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x11e

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4a3

    aput v3, v2, v5

    const v3, 0x7f08035a

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x11f

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4a4

    aput v3, v2, v5

    const v3, 0x7f08035b

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x120

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4a5

    aput v3, v2, v5

    const v3, 0x7f08035c

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x121

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4a6

    aput v3, v2, v5

    const v3, 0x7f08035d

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x122

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4a7

    aput v3, v2, v5

    const v3, 0x7f08035e

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x123

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4a8

    aput v3, v2, v5

    const v3, 0x7f08035f

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x124

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4aa

    aput v3, v2, v5

    const v3, 0x7f080361

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x125

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4ab

    aput v3, v2, v5

    const v3, 0x7f080362

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x126

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4ac

    aput v3, v2, v5

    const v3, 0x7f080363

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x127

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4ad

    aput v3, v2, v5

    const v3, 0x7f080364

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x128

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4ae

    aput v3, v2, v5

    const v3, 0x7f080365

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x129

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4af

    aput v3, v2, v5

    const v3, 0x7f080366

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x12a

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4b0

    aput v3, v2, v5

    const v3, 0x7f080367

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x12b

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4b1

    aput v3, v2, v5

    const v3, 0x7f080368

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x12c

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4b2

    aput v3, v2, v5

    const v3, 0x7f080369

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x12d

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4b3

    aput v3, v2, v5

    const v3, 0x7f08036a

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x12e

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4b4

    aput v3, v2, v5

    const v3, 0x7f08036b

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x12f

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4b5

    aput v3, v2, v5

    const v3, 0x7f08036c

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x130

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4b6

    aput v3, v2, v5

    const v3, 0x7f08036d

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x131

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4b7

    aput v3, v2, v5

    const v3, 0x7f08036e

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x132

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4b8

    aput v3, v2, v5

    const v3, 0x7f08036f

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x133

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4b9

    aput v3, v2, v5

    const v3, 0x7f080370

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x134

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4ba

    aput v3, v2, v5

    const v3, 0x7f080371

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x135

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4bb

    aput v3, v2, v5

    const v3, 0x7f080372

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x136

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4bc

    aput v3, v2, v5

    const v3, 0x7f080373

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x137

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4bd

    aput v3, v2, v5

    const v3, 0x7f080374

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x138

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4be

    aput v3, v2, v5

    const v3, 0x7f080375

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x139

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4bf

    aput v3, v2, v5

    const v3, 0x7f080376

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x13a

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4c0

    aput v3, v2, v5

    const v3, 0x7f080377

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x13b

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4c1

    aput v3, v2, v5

    const v3, 0x7f080378

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x13c

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4c2

    aput v3, v2, v5

    const v3, 0x7f080379

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x13d

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4c3

    aput v3, v2, v5

    const v3, 0x7f08037a

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x13e

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4c4

    aput v3, v2, v5

    const v3, 0x7f08037b

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x13f

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4c5

    aput v3, v2, v5

    const v3, 0x7f08037c

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x140

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4c6

    aput v3, v2, v5

    const v3, 0x7f08037d

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x141

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4c7

    aput v3, v2, v5

    const v3, 0x7f08037e

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x142

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4c8

    aput v3, v2, v5

    const v3, 0x7f08037f

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x143

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4c9

    aput v3, v2, v5

    const v3, 0x7f080380

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x144

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4ca

    aput v3, v2, v5

    const v3, 0x7f080381

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x145

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4cb

    aput v3, v2, v5

    const v3, 0x7f080382

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x146

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4cc

    aput v3, v2, v5

    const v3, 0x7f080383

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x147

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4cd

    aput v3, v2, v5

    const v3, 0x7f080384

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x148

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4ce

    aput v3, v2, v5

    const v3, 0x7f080385

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x149

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4cf

    aput v3, v2, v5

    const v3, 0x7f080386

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x14a

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4d0

    aput v3, v2, v5

    const v3, 0x7f080387

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x14b

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4d1

    aput v3, v2, v5

    const v3, 0x7f080388

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x14c

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4d2

    aput v3, v2, v5

    const v3, 0x7f080389

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x14d

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4d3

    aput v3, v2, v5

    const v3, 0x7f08038a

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x14e

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4d4

    aput v3, v2, v5

    const v3, 0x7f08038b

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x14f

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4d5

    aput v3, v2, v5

    const v3, 0x7f08038c

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x150

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4d6

    aput v3, v2, v5

    const v3, 0x7f08038d

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x151

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4d7

    aput v3, v2, v5

    const v3, 0x7f08038e

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x152

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4d8

    aput v3, v2, v5

    const v3, 0x7f08038f

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x153

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4d9

    aput v3, v2, v5

    const v3, 0x7f080390

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x154

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4da

    aput v3, v2, v5

    const v3, 0x7f080391

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x155

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4db

    aput v3, v2, v5

    const v3, 0x7f080392

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x156

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4dc

    aput v3, v2, v5

    const v3, 0x7f080393

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x157

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4dd

    aput v3, v2, v5

    const v3, 0x7f080394

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x158

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4de

    aput v3, v2, v5

    const v3, 0x7f080395

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x159

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4df

    aput v3, v2, v5

    const v3, 0x7f080396

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x15a

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4e0

    aput v3, v2, v5

    const v3, 0x7f080397

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x15b

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4e1

    aput v3, v2, v5

    const v3, 0x7f080398

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x15c

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4e2

    aput v3, v2, v5

    const v3, 0x7f080399

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x15d

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4e3

    aput v3, v2, v5

    const v3, 0x7f08039a

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x15e

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4e4

    aput v3, v2, v5

    const v3, 0x7f08039b

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x15f

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4e5

    aput v3, v2, v5

    const v3, 0x7f08039c

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x160

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4e6

    aput v3, v2, v5

    const v3, 0x7f08039d

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x161

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4e7

    aput v3, v2, v5

    const v3, 0x7f08039e

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x162

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4e8

    aput v3, v2, v5

    const v3, 0x7f08039f

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x163

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4e9

    aput v3, v2, v5

    const v3, 0x7f0803a0

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x164

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4ea

    aput v3, v2, v5

    const v3, 0x7f0803a1

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x165

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4eb

    aput v3, v2, v5

    const v3, 0x7f0803a2

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x166

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4ec

    aput v3, v2, v5

    const v3, 0x7f0803a3

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x167

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4ed

    aput v3, v2, v5

    const v3, 0x7f0803a4

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x168

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4ee

    aput v3, v2, v5

    const v3, 0x7f0803a5

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x169

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4ef

    aput v3, v2, v5

    const v3, 0x7f0803a6

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x16a

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4f0

    aput v3, v2, v5

    const v3, 0x7f0803a7

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x16b

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4f1

    aput v3, v2, v5

    const v3, 0x7f0803a8

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x16c

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4f2

    aput v3, v2, v5

    const v3, 0x7f0803a9

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x16d

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4f5

    aput v3, v2, v5

    const v3, 0x7f0803ac

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x16e

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4f7

    aput v3, v2, v5

    const v3, 0x7f0803ae

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x16f

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4f9

    aput v3, v2, v5

    const v3, 0x7f0803af

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x170

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4fa

    aput v3, v2, v5

    const v3, 0x7f0803b0

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x171

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4fb

    aput v3, v2, v5

    const v3, 0x7f0803b1

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x172

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f4fc

    aput v3, v2, v5

    const v3, 0x7f0803b2

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x173

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f503

    aput v3, v2, v5

    const v3, 0x7f0803b6

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x174

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f505

    aput v3, v2, v5

    const v3, 0x7f0803b8

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x175

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f506

    aput v3, v2, v5

    const v3, 0x7f0803b9

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x176

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f507

    aput v3, v2, v5

    const v3, 0x7f0803ba

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x177

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f509

    aput v3, v2, v5

    const v3, 0x7f0803bb

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x178

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f50a

    aput v3, v2, v5

    const v3, 0x7f0803bc

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x179

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f50b

    aput v3, v2, v5

    const v3, 0x7f0803bd

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x17a

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f50c

    aput v3, v2, v5

    const v3, 0x7f0803be

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x17b

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f50d

    aput v3, v2, v5

    const v3, 0x7f0803bf

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x17c

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f50e

    aput v3, v2, v5

    const v3, 0x7f0803c0

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x17d

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f50f

    aput v3, v2, v5

    const v3, 0x7f0803c1

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x17e

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f510

    aput v3, v2, v5

    const v3, 0x7f0803c2

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x17f

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f511

    aput v3, v2, v5

    const v3, 0x7f0803c3

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x180

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f512

    aput v3, v2, v5

    const v3, 0x7f0803c4

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x181

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f513

    aput v3, v2, v5

    const v3, 0x7f0803c5

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x182

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f514

    aput v3, v2, v5

    const v3, 0x7f0803c6

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x183

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f515

    aput v3, v2, v5

    const v3, 0x7f0803c7

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x184

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f516

    aput v3, v2, v5

    const v3, 0x7f0803c8

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x185

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f517

    aput v3, v2, v5

    const v3, 0x7f0803c9

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x186

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f518

    aput v3, v2, v5

    const v3, 0x7f0803ca

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x187

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f519

    aput v3, v2, v5

    const v3, 0x7f0803cb

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x188

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f51a

    aput v3, v2, v5

    const v3, 0x7f0803cc

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x189

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f51b

    aput v3, v2, v5

    const v3, 0x7f0803cd

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x18a

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f51c

    aput v3, v2, v5

    const v3, 0x7f0803ce

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x18b

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f51e

    aput v3, v2, v5

    const v3, 0x7f0803d0

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x18c

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f525

    aput v3, v2, v5

    const v3, 0x7f0803d7

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x18d

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f526

    aput v3, v2, v5

    const v3, 0x7f0803d8

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x18e

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f527

    aput v3, v2, v5

    const v3, 0x7f0803d9

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x18f

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f528

    aput v3, v2, v5

    const v3, 0x7f0803da

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x190

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f529

    aput v3, v2, v5

    const v3, 0x7f0803db

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x191

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f52a

    aput v3, v2, v5

    const v3, 0x7f0803dc

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x192

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f52b

    aput v3, v2, v5

    const v3, 0x7f0803dd

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x193

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f52c

    aput v3, v2, v5

    const v3, 0x7f0803de

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x194

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f52d

    aput v3, v2, v5

    const v3, 0x7f0803df

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x195

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f52e

    aput v3, v2, v5

    const v3, 0x7f0803e0

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x196

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f530

    aput v3, v2, v5

    const v3, 0x7f0803e2

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x197

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f531

    aput v3, v2, v5

    const v3, 0x7f0803e3

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x198

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f532

    aput v3, v2, v5

    const v3, 0x7f0803e4

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x199

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f533

    aput v3, v2, v5

    const v3, 0x7f0803e5

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x19a

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f534

    aput v3, v2, v5

    const v3, 0x7f0803e6

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x19b

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f535

    aput v3, v2, v5

    const v3, 0x7f0803e7

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x19c

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f536

    aput v3, v2, v5

    const v3, 0x7f0803e8

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x19d

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f537

    aput v3, v2, v5

    const v3, 0x7f0803e9

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x19e

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f538

    aput v3, v2, v5

    const v3, 0x7f0803ea

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x19f

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f539

    aput v3, v2, v5

    const v3, 0x7f0803eb

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x1a0

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f53a

    aput v3, v2, v5

    const v3, 0x7f0803ec

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x1a1

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f53b

    aput v3, v2, v5

    const v3, 0x7f0803ed

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x1a2

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f550

    aput v3, v2, v5

    const v3, 0x7f0803f0

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x1a3

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f551

    aput v3, v2, v5

    const v3, 0x7f0803f1

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x1a4

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f552

    aput v3, v2, v5

    const v3, 0x7f0803f2

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x1a5

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f553

    aput v3, v2, v5

    const v3, 0x7f0803f3

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x1a6

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f554

    aput v3, v2, v5

    const v3, 0x7f0803f4

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x1a7

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f555

    aput v3, v2, v5

    const v3, 0x7f0803f5

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x1a8

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f556

    aput v3, v2, v5

    const v3, 0x7f0803f6

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x1a9

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f557

    aput v3, v2, v5

    const v3, 0x7f0803f7

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x1aa

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f558

    aput v3, v2, v5

    const v3, 0x7f0803f8

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x1ab

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f559

    aput v3, v2, v5

    const v3, 0x7f0803f9

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x1ac

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f55a

    aput v3, v2, v5

    const v3, 0x7f0803fa

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x1ad

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f55b

    aput v3, v2, v5

    const v3, 0x7f0803fb

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x1ae

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f55c

    aput v3, v2, v5

    const v3, 0x7f0803fc

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x1af

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f55d

    aput v3, v2, v5

    const v3, 0x7f0803fd

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x1b0

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f55e

    aput v3, v2, v5

    const v3, 0x7f0803fe

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x1b1

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f55f

    aput v3, v2, v5

    const v3, 0x7f0803ff

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x1b2

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f560

    aput v3, v2, v5

    const v3, 0x7f080400

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x1b3

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f561

    aput v3, v2, v5

    const v3, 0x7f080401

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x1b4

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f562

    aput v3, v2, v5

    const v3, 0x7f080402

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x1b5

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f563

    aput v3, v2, v5

    const v3, 0x7f080403

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x1b6

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f564

    aput v3, v2, v5

    const v3, 0x7f080404

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x1b7

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f565

    aput v3, v2, v5

    const v3, 0x7f080405

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x1b8

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f566

    aput v3, v2, v5

    const v3, 0x7f080406

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x1b9

    aput-object v1, v0, v2

    new-instance v1, Lchat/ola/vn/entry/h;

    new-array v2, v6, [I

    const v3, 0x1f567

    aput v3, v2, v5

    const v3, 0x7f080407

    invoke-direct {v1, v3, v6, v2}, Lchat/ola/vn/entry/h;-><init>(IS[I)V

    const/16 v2, 0x1ba

    aput-object v1, v0, v2

    sput-object v0, Lchat/ola/vn/r/c;->e:[Lchat/ola/vn/entry/h;

    return-void

    :array_0
    .array-data 4
        0x1f1e9
        0x1f1ea
    .end array-data

    :array_1
    .array-data 4
        0x1f1ea
        0x1f1f8
    .end array-data

    :array_2
    .array-data 4
        0x1f1eb
        0x1f1f7
    .end array-data

    :array_3
    .array-data 4
        0x1f1ec
        0x1f1e7
    .end array-data

    :array_4
    .array-data 4
        0x1f1ee
        0x1f1f9
    .end array-data

    :array_5
    .array-data 4
        0x1f1ef
        0x1f1f5
    .end array-data

    :array_6
    .array-data 4
        0x1f1f0
        0x1f1f7
    .end array-data

    :array_7
    .array-data 4
        0x1f1f7
        0x1f1fa
    .end array-data

    :array_8
    .array-data 4
        0x1f1fa
        0x1f1f8
    .end array-data
.end method

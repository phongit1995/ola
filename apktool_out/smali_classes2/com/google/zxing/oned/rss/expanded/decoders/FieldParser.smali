.class final Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;
.super Ljava/lang/Object;


# static fields
.field private static final FOUR_DIGIT_DATA_LENGTH:[[Ljava/lang/Object;

.field private static final THREE_DIGIT_DATA_LENGTH:[[Ljava/lang/Object;

.field private static final THREE_DIGIT_PLUS_DIGIT_DATA_LENGTH:[[Ljava/lang/Object;

.field private static final TWO_DIGIT_DATA_LENGTH:[[Ljava/lang/Object;

.field private static final VARIABLE_LENGTH:Ljava/lang/Object;


# direct methods
.method static constructor <clinit>()V
    .locals 18

    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    const/16 v0, 0x18

    new-array v0, v0, [[Ljava/lang/Object;

    const/4 v1, 0x2

    new-array v2, v1, [Ljava/lang/Object;

    const-string v3, "00"

    const/4 v4, 0x0

    aput-object v3, v2, v4

    const/16 v3, 0x12

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    const/4 v6, 0x1

    aput-object v5, v2, v6

    aput-object v2, v0, v4

    new-array v2, v1, [Ljava/lang/Object;

    const-string v5, "01"

    aput-object v5, v2, v4

    const/16 v5, 0xe

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    aput-object v7, v2, v6

    aput-object v2, v0, v6

    new-array v2, v1, [Ljava/lang/Object;

    const-string v7, "02"

    aput-object v7, v2, v4

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    aput-object v7, v2, v6

    aput-object v2, v0, v1

    const/4 v2, 0x3

    new-array v7, v2, [Ljava/lang/Object;

    const-string v8, "10"

    aput-object v8, v7, v4

    sget-object v8, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    aput-object v8, v7, v6

    const/16 v8, 0x14

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v9

    aput-object v9, v7, v1

    aput-object v7, v0, v2

    new-array v7, v1, [Ljava/lang/Object;

    const-string v9, "11"

    aput-object v9, v7, v4

    const/4 v9, 0x6

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v10

    aput-object v10, v7, v6

    const/4 v10, 0x4

    aput-object v7, v0, v10

    new-array v7, v1, [Ljava/lang/Object;

    const-string v10, "12"

    aput-object v10, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v10

    aput-object v10, v7, v6

    const/4 v10, 0x5

    aput-object v7, v0, v10

    new-array v7, v1, [Ljava/lang/Object;

    const-string v10, "13"

    aput-object v10, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v10

    aput-object v10, v7, v6

    aput-object v7, v0, v9

    new-array v7, v1, [Ljava/lang/Object;

    const-string v10, "15"

    aput-object v10, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v10

    aput-object v10, v7, v6

    const/4 v10, 0x7

    aput-object v7, v0, v10

    new-array v7, v1, [Ljava/lang/Object;

    const-string v10, "17"

    aput-object v10, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v10

    aput-object v10, v7, v6

    const/16 v10, 0x8

    aput-object v7, v0, v10

    new-array v7, v1, [Ljava/lang/Object;

    const-string v11, "20"

    aput-object v11, v7, v4

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v11

    aput-object v11, v7, v6

    const/16 v11, 0x9

    aput-object v7, v0, v11

    new-array v7, v2, [Ljava/lang/Object;

    const-string v11, "21"

    aput-object v11, v7, v4

    sget-object v11, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    aput-object v11, v7, v6

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v11

    aput-object v11, v7, v1

    const/16 v11, 0xa

    aput-object v7, v0, v11

    new-array v7, v2, [Ljava/lang/Object;

    const-string v12, "22"

    aput-object v12, v7, v4

    sget-object v12, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    aput-object v12, v7, v6

    const/16 v12, 0x1d

    invoke-static {v12}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v12

    aput-object v12, v7, v1

    const/16 v12, 0xb

    aput-object v7, v0, v12

    new-array v7, v2, [Ljava/lang/Object;

    const-string v12, "30"

    aput-object v12, v7, v4

    sget-object v12, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    aput-object v12, v7, v6

    invoke-static {v10}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v12

    aput-object v12, v7, v1

    const/16 v12, 0xc

    aput-object v7, v0, v12

    new-array v7, v2, [Ljava/lang/Object;

    const-string v13, "37"

    aput-object v13, v7, v4

    sget-object v13, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    aput-object v13, v7, v6

    invoke-static {v10}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v13

    aput-object v13, v7, v1

    const/16 v13, 0xd

    aput-object v7, v0, v13

    new-array v7, v2, [Ljava/lang/Object;

    const-string v14, "90"

    aput-object v14, v7, v4

    sget-object v14, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    aput-object v14, v7, v6

    const/16 v14, 0x1e

    invoke-static {v14}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v15

    aput-object v15, v7, v1

    aput-object v7, v0, v5

    new-array v7, v2, [Ljava/lang/Object;

    const-string v15, "91"

    aput-object v15, v7, v4

    sget-object v15, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    aput-object v15, v7, v6

    invoke-static {v14}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v15

    aput-object v15, v7, v1

    const/16 v15, 0xf

    aput-object v7, v0, v15

    new-array v7, v2, [Ljava/lang/Object;

    const-string v16, "92"

    aput-object v16, v7, v4

    sget-object v16, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    aput-object v16, v7, v6

    invoke-static {v14}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v16

    aput-object v16, v7, v1

    const/16 v16, 0x10

    aput-object v7, v0, v16

    new-array v7, v2, [Ljava/lang/Object;

    const-string v16, "93"

    aput-object v16, v7, v4

    sget-object v16, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    aput-object v16, v7, v6

    invoke-static {v14}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v16

    aput-object v16, v7, v1

    const/16 v15, 0x11

    aput-object v7, v0, v15

    new-array v7, v2, [Ljava/lang/Object;

    const-string v16, "94"

    aput-object v16, v7, v4

    sget-object v16, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    aput-object v16, v7, v6

    invoke-static {v14}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v16

    aput-object v16, v7, v1

    aput-object v7, v0, v3

    new-array v7, v2, [Ljava/lang/Object;

    const-string v16, "95"

    aput-object v16, v7, v4

    sget-object v16, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    aput-object v16, v7, v6

    invoke-static {v14}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v16

    aput-object v16, v7, v1

    const/16 v16, 0x13

    aput-object v7, v0, v16

    new-array v7, v2, [Ljava/lang/Object;

    const-string v16, "96"

    aput-object v16, v7, v4

    sget-object v16, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    aput-object v16, v7, v6

    invoke-static {v14}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v16

    aput-object v16, v7, v1

    aput-object v7, v0, v8

    new-array v7, v2, [Ljava/lang/Object;

    const-string v16, "97"

    aput-object v16, v7, v4

    sget-object v16, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    aput-object v16, v7, v6

    invoke-static {v14}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v16

    aput-object v16, v7, v1

    const/16 v16, 0x15

    aput-object v7, v0, v16

    new-array v7, v2, [Ljava/lang/Object;

    const-string v16, "98"

    aput-object v16, v7, v4

    sget-object v16, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    aput-object v16, v7, v6

    invoke-static {v14}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v16

    aput-object v16, v7, v1

    const/16 v16, 0x16

    aput-object v7, v0, v16

    new-array v7, v2, [Ljava/lang/Object;

    const-string v16, "99"

    aput-object v16, v7, v4

    sget-object v16, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    aput-object v16, v7, v6

    invoke-static {v14}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v16

    aput-object v16, v7, v1

    const/16 v16, 0x17

    aput-object v7, v0, v16

    sput-object v0, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->TWO_DIGIT_DATA_LENGTH:[[Ljava/lang/Object;

    const/16 v0, 0x17

    new-array v0, v0, [[Ljava/lang/Object;

    new-array v7, v2, [Ljava/lang/Object;

    const-string v16, "240"

    aput-object v16, v7, v4

    sget-object v16, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    aput-object v16, v7, v6

    invoke-static {v14}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v16

    aput-object v16, v7, v1

    aput-object v7, v0, v4

    new-array v7, v2, [Ljava/lang/Object;

    const-string v16, "241"

    aput-object v16, v7, v4

    sget-object v16, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    aput-object v16, v7, v6

    invoke-static {v14}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v16

    aput-object v16, v7, v1

    aput-object v7, v0, v6

    new-array v7, v2, [Ljava/lang/Object;

    const-string v16, "242"

    aput-object v16, v7, v4

    sget-object v16, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    aput-object v16, v7, v6

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v16

    aput-object v16, v7, v1

    aput-object v7, v0, v1

    new-array v7, v2, [Ljava/lang/Object;

    const-string v16, "250"

    aput-object v16, v7, v4

    sget-object v16, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    aput-object v16, v7, v6

    invoke-static {v14}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v16

    aput-object v16, v7, v1

    aput-object v7, v0, v2

    new-array v7, v2, [Ljava/lang/Object;

    const-string v16, "251"

    aput-object v16, v7, v4

    sget-object v16, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    aput-object v16, v7, v6

    invoke-static {v14}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v16

    aput-object v16, v7, v1

    const/16 v16, 0x4

    aput-object v7, v0, v16

    new-array v7, v2, [Ljava/lang/Object;

    const-string v16, "253"

    aput-object v16, v7, v4

    sget-object v16, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    aput-object v16, v7, v6

    invoke-static {v15}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v16

    aput-object v16, v7, v1

    const/16 v16, 0x5

    aput-object v7, v0, v16

    new-array v7, v2, [Ljava/lang/Object;

    const-string v16, "254"

    aput-object v16, v7, v4

    sget-object v16, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    aput-object v16, v7, v6

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v16

    aput-object v16, v7, v1

    aput-object v7, v0, v9

    new-array v7, v2, [Ljava/lang/Object;

    const-string v16, "400"

    aput-object v16, v7, v4

    sget-object v16, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    aput-object v16, v7, v6

    invoke-static {v14}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v16

    aput-object v16, v7, v1

    const/16 v16, 0x7

    aput-object v7, v0, v16

    new-array v7, v2, [Ljava/lang/Object;

    const-string v16, "401"

    aput-object v16, v7, v4

    sget-object v16, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    aput-object v16, v7, v6

    invoke-static {v14}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v16

    aput-object v16, v7, v1

    aput-object v7, v0, v10

    new-array v7, v1, [Ljava/lang/Object;

    const-string v16, "402"

    aput-object v16, v7, v4

    invoke-static {v15}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v16

    aput-object v16, v7, v6

    const/16 v16, 0x9

    aput-object v7, v0, v16

    new-array v7, v2, [Ljava/lang/Object;

    const-string v16, "403"

    aput-object v16, v7, v4

    sget-object v16, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    aput-object v16, v7, v6

    invoke-static {v14}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v16

    aput-object v16, v7, v1

    aput-object v7, v0, v11

    new-array v7, v1, [Ljava/lang/Object;

    const-string v16, "410"

    aput-object v16, v7, v4

    invoke-static {v13}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v16

    aput-object v16, v7, v6

    const/16 v16, 0xb

    aput-object v7, v0, v16

    new-array v7, v1, [Ljava/lang/Object;

    const-string v16, "411"

    aput-object v16, v7, v4

    invoke-static {v13}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v16

    aput-object v16, v7, v6

    aput-object v7, v0, v12

    new-array v7, v1, [Ljava/lang/Object;

    const-string v16, "412"

    aput-object v16, v7, v4

    invoke-static {v13}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v16

    aput-object v16, v7, v6

    aput-object v7, v0, v13

    new-array v7, v1, [Ljava/lang/Object;

    const-string v16, "413"

    aput-object v16, v7, v4

    invoke-static {v13}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v16

    aput-object v16, v7, v6

    aput-object v7, v0, v5

    new-array v7, v1, [Ljava/lang/Object;

    const-string v16, "414"

    aput-object v16, v7, v4

    invoke-static {v13}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v16

    aput-object v16, v7, v6

    const/16 v16, 0xf

    aput-object v7, v0, v16

    new-array v7, v2, [Ljava/lang/Object;

    const-string v16, "420"

    aput-object v16, v7, v4

    sget-object v16, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    aput-object v16, v7, v6

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v16

    aput-object v16, v7, v1

    const/16 v16, 0x10

    aput-object v7, v0, v16

    new-array v7, v2, [Ljava/lang/Object;

    const-string v16, "421"

    aput-object v16, v7, v4

    sget-object v16, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    aput-object v16, v7, v6

    const/16 v14, 0xf

    invoke-static {v14}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v16

    aput-object v16, v7, v1

    aput-object v7, v0, v15

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "422"

    aput-object v14, v7, v4

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    aput-object v7, v0, v3

    new-array v7, v2, [Ljava/lang/Object;

    const-string v14, "423"

    aput-object v14, v7, v4

    sget-object v14, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    aput-object v14, v7, v6

    const/16 v14, 0xf

    invoke-static {v14}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v16

    aput-object v16, v7, v1

    const/16 v14, 0x13

    aput-object v7, v0, v14

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "424"

    aput-object v14, v7, v4

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    aput-object v7, v0, v8

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "425"

    aput-object v14, v7, v4

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    const/16 v14, 0x15

    aput-object v7, v0, v14

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "426"

    aput-object v14, v7, v4

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    const/16 v14, 0x16

    aput-object v7, v0, v14

    sput-object v0, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->THREE_DIGIT_DATA_LENGTH:[[Ljava/lang/Object;

    const/16 v0, 0x39

    new-array v0, v0, [[Ljava/lang/Object;

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "310"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    aput-object v7, v0, v4

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "311"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    aput-object v7, v0, v6

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "312"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    aput-object v7, v0, v1

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "313"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    aput-object v7, v0, v2

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "314"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    const/4 v14, 0x4

    aput-object v7, v0, v14

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "315"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    const/4 v14, 0x5

    aput-object v7, v0, v14

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "316"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    aput-object v7, v0, v9

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "320"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    const/4 v14, 0x7

    aput-object v7, v0, v14

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "321"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    aput-object v7, v0, v10

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "322"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    const/16 v14, 0x9

    aput-object v7, v0, v14

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "323"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    aput-object v7, v0, v11

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "324"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    const/16 v14, 0xb

    aput-object v7, v0, v14

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "325"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    aput-object v7, v0, v12

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "326"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    aput-object v7, v0, v13

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "327"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    aput-object v7, v0, v5

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "328"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    const/16 v14, 0xf

    aput-object v7, v0, v14

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "329"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    const/16 v14, 0x10

    aput-object v7, v0, v14

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "330"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    aput-object v7, v0, v15

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "331"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    aput-object v7, v0, v3

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "332"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    const/16 v14, 0x13

    aput-object v7, v0, v14

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "333"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    aput-object v7, v0, v8

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "334"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    const/16 v14, 0x15

    aput-object v7, v0, v14

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "335"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    const/16 v14, 0x16

    aput-object v7, v0, v14

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "336"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    const/16 v14, 0x17

    aput-object v7, v0, v14

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "340"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    const/16 v14, 0x18

    aput-object v7, v0, v14

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "341"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    const/16 v14, 0x19

    aput-object v7, v0, v14

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "342"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    const/16 v14, 0x1a

    aput-object v7, v0, v14

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "343"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    const/16 v14, 0x1b

    aput-object v7, v0, v14

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "344"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    const/16 v14, 0x1c

    aput-object v7, v0, v14

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "345"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    const/16 v14, 0x1d

    aput-object v7, v0, v14

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "346"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    const/16 v14, 0x1e

    aput-object v7, v0, v14

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "347"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    const/16 v14, 0x1f

    aput-object v7, v0, v14

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "348"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    const/16 v14, 0x20

    aput-object v7, v0, v14

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "349"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    const/16 v14, 0x21

    aput-object v7, v0, v14

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "350"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    const/16 v14, 0x22

    aput-object v7, v0, v14

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "351"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    const/16 v14, 0x23

    aput-object v7, v0, v14

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "352"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    const/16 v14, 0x24

    aput-object v7, v0, v14

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "353"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    const/16 v14, 0x25

    aput-object v7, v0, v14

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "354"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    const/16 v14, 0x26

    aput-object v7, v0, v14

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "355"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    const/16 v14, 0x27

    aput-object v7, v0, v14

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "356"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    const/16 v14, 0x28

    aput-object v7, v0, v14

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "357"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    const/16 v14, 0x29

    aput-object v7, v0, v14

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "360"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    const/16 v14, 0x2a

    aput-object v7, v0, v14

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "361"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    const/16 v14, 0x2b

    aput-object v7, v0, v14

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "362"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    const/16 v14, 0x2c

    aput-object v7, v0, v14

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "363"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    const/16 v14, 0x2d

    aput-object v7, v0, v14

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "364"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    const/16 v14, 0x2e

    aput-object v7, v0, v14

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "365"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    const/16 v14, 0x2f

    aput-object v7, v0, v14

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "366"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    const/16 v14, 0x30

    aput-object v7, v0, v14

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "367"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    const/16 v14, 0x31

    aput-object v7, v0, v14

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "368"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    const/16 v14, 0x32

    aput-object v7, v0, v14

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "369"

    aput-object v14, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    const/16 v14, 0x33

    aput-object v7, v0, v14

    new-array v7, v2, [Ljava/lang/Object;

    const-string v14, "390"

    aput-object v14, v7, v4

    sget-object v14, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    aput-object v14, v7, v6

    const/16 v14, 0xf

    invoke-static {v14}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v16

    aput-object v16, v7, v1

    const/16 v14, 0x34

    aput-object v7, v0, v14

    new-array v7, v2, [Ljava/lang/Object;

    const-string v14, "391"

    aput-object v14, v7, v4

    sget-object v14, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    aput-object v14, v7, v6

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v1

    const/16 v14, 0x35

    aput-object v7, v0, v14

    new-array v7, v2, [Ljava/lang/Object;

    const-string v14, "392"

    aput-object v14, v7, v4

    sget-object v14, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    aput-object v14, v7, v6

    const/16 v14, 0xf

    invoke-static {v14}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v16

    aput-object v16, v7, v1

    const/16 v14, 0x36

    aput-object v7, v0, v14

    new-array v7, v2, [Ljava/lang/Object;

    const-string v14, "393"

    aput-object v14, v7, v4

    sget-object v14, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    aput-object v14, v7, v6

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v1

    const/16 v14, 0x37

    aput-object v7, v0, v14

    new-array v7, v2, [Ljava/lang/Object;

    const-string v14, "703"

    aput-object v14, v7, v4

    sget-object v14, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    aput-object v14, v7, v6

    const/16 v14, 0x1e

    invoke-static {v14}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v16

    aput-object v16, v7, v1

    const/16 v14, 0x38

    aput-object v7, v0, v14

    sput-object v0, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->THREE_DIGIT_PLUS_DIGIT_DATA_LENGTH:[[Ljava/lang/Object;

    new-array v0, v3, [[Ljava/lang/Object;

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "7001"

    aput-object v14, v7, v4

    invoke-static {v13}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    aput-object v7, v0, v4

    new-array v7, v2, [Ljava/lang/Object;

    const-string v14, "7002"

    aput-object v14, v7, v4

    sget-object v14, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    aput-object v14, v7, v6

    const/16 v14, 0x1e

    invoke-static {v14}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v16

    aput-object v16, v7, v1

    aput-object v7, v0, v6

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "7003"

    aput-object v14, v7, v4

    invoke-static {v11}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    aput-object v7, v0, v1

    new-array v7, v1, [Ljava/lang/Object;

    const-string v14, "8001"

    aput-object v14, v7, v4

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v6

    aput-object v7, v0, v2

    new-array v7, v2, [Ljava/lang/Object;

    const-string v14, "8002"

    aput-object v14, v7, v4

    sget-object v14, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    aput-object v14, v7, v6

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    aput-object v8, v7, v1

    const/4 v8, 0x4

    aput-object v7, v0, v8

    new-array v7, v2, [Ljava/lang/Object;

    const-string v8, "8003"

    aput-object v8, v7, v4

    sget-object v8, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    aput-object v8, v7, v6

    const/16 v8, 0x1e

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v1

    const/4 v14, 0x5

    aput-object v7, v0, v14

    new-array v7, v2, [Ljava/lang/Object;

    const-string v14, "8004"

    aput-object v14, v7, v4

    sget-object v14, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    aput-object v14, v7, v6

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v7, v1

    aput-object v7, v0, v9

    new-array v7, v1, [Ljava/lang/Object;

    const-string v8, "8005"

    aput-object v8, v7, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    aput-object v8, v7, v6

    const/4 v8, 0x7

    aput-object v7, v0, v8

    new-array v7, v1, [Ljava/lang/Object;

    const-string v8, "8006"

    aput-object v8, v7, v4

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    aput-object v8, v7, v6

    aput-object v7, v0, v10

    new-array v7, v2, [Ljava/lang/Object;

    const-string v8, "8007"

    aput-object v8, v7, v4

    sget-object v8, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    aput-object v8, v7, v6

    const/16 v8, 0x1e

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    aput-object v8, v7, v1

    const/16 v8, 0x9

    aput-object v7, v0, v8

    new-array v7, v2, [Ljava/lang/Object;

    const-string v8, "8008"

    aput-object v8, v7, v4

    sget-object v8, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    aput-object v8, v7, v6

    invoke-static {v12}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    aput-object v8, v7, v1

    aput-object v7, v0, v11

    new-array v7, v1, [Ljava/lang/Object;

    const-string v8, "8018"

    aput-object v8, v7, v4

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v7, v6

    const/16 v3, 0xb

    aput-object v7, v0, v3

    new-array v3, v2, [Ljava/lang/Object;

    const-string v7, "8020"

    aput-object v7, v3, v4

    sget-object v7, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    aput-object v7, v3, v6

    const/16 v7, 0x19

    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    aput-object v7, v3, v1

    aput-object v3, v0, v12

    new-array v3, v1, [Ljava/lang/Object;

    const-string v7, "8100"

    aput-object v7, v3, v4

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    aput-object v7, v3, v6

    aput-object v3, v0, v13

    new-array v3, v1, [Ljava/lang/Object;

    const-string v7, "8101"

    aput-object v7, v3, v4

    invoke-static {v11}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    aput-object v7, v3, v6

    aput-object v3, v0, v5

    new-array v3, v1, [Ljava/lang/Object;

    const-string v5, "8102"

    aput-object v5, v3, v4

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v3, v6

    const/16 v5, 0xf

    aput-object v3, v0, v5

    new-array v3, v2, [Ljava/lang/Object;

    const-string v5, "8110"

    aput-object v5, v3, v4

    sget-object v5, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    aput-object v5, v3, v6

    const/16 v5, 0x46

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v3, v1

    const/16 v5, 0x10

    aput-object v3, v0, v5

    new-array v2, v2, [Ljava/lang/Object;

    const-string v3, "8200"

    aput-object v3, v2, v4

    sget-object v3, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    aput-object v3, v2, v6

    const/16 v3, 0x46

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v2, v1

    aput-object v2, v0, v15

    sput-object v0, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->FOUR_DIGIT_DATA_LENGTH:[[Ljava/lang/Object;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static parseFieldsInGeneralPurpose(Ljava/lang/String;)Ljava/lang/String;
    .locals 10

    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 p0, 0x0

    return-object p0

    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    const/4 v1, 0x2

    if-ge v0, v1, :cond_1

    invoke-static {}, Lcom/google/zxing/NotFoundException;->getNotFoundInstance()Lcom/google/zxing/NotFoundException;

    move-result-object p0

    throw p0

    :cond_1
    const/4 v0, 0x0

    invoke-virtual {p0, v0, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    sget-object v3, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->TWO_DIGIT_DATA_LENGTH:[[Ljava/lang/Object;

    array-length v4, v3

    const/4 v5, 0x0

    :goto_0
    const/4 v6, 0x1

    if-ge v5, v4, :cond_4

    aget-object v7, v3, v5

    aget-object v8, v7, v0

    invoke-virtual {v8, v2}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_3

    aget-object v0, v7, v6

    sget-object v2, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    if-ne v0, v2, :cond_2

    aget-object v0, v7, v1

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    invoke-static {v1, v0, p0}, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->processVariableAI(IILjava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0

    :cond_2
    aget-object v0, v7, v6

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    invoke-static {v1, v0, p0}, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->processFixedAI(IILjava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0

    :cond_3
    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    :cond_4
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    const/4 v3, 0x3

    if-ge v2, v3, :cond_5

    invoke-static {}, Lcom/google/zxing/NotFoundException;->getNotFoundInstance()Lcom/google/zxing/NotFoundException;

    move-result-object p0

    throw p0

    :cond_5
    invoke-virtual {p0, v0, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    sget-object v4, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->THREE_DIGIT_DATA_LENGTH:[[Ljava/lang/Object;

    array-length v5, v4

    const/4 v7, 0x0

    :goto_1
    if-ge v7, v5, :cond_8

    aget-object v8, v4, v7

    aget-object v9, v8, v0

    invoke-virtual {v9, v2}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_7

    aget-object v0, v8, v6

    sget-object v2, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    if-ne v0, v2, :cond_6

    aget-object v0, v8, v1

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    invoke-static {v3, v0, p0}, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->processVariableAI(IILjava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0

    :cond_6
    aget-object v0, v8, v6

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    invoke-static {v3, v0, p0}, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->processFixedAI(IILjava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0

    :cond_7
    add-int/lit8 v7, v7, 0x1

    goto :goto_1

    :cond_8
    sget-object v3, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->THREE_DIGIT_PLUS_DIGIT_DATA_LENGTH:[[Ljava/lang/Object;

    array-length v4, v3

    const/4 v5, 0x0

    :goto_2
    const/4 v7, 0x4

    if-ge v5, v4, :cond_b

    aget-object v8, v3, v5

    aget-object v9, v8, v0

    invoke-virtual {v9, v2}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_a

    aget-object v0, v8, v6

    sget-object v2, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    if-ne v0, v2, :cond_9

    aget-object v0, v8, v1

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    invoke-static {v7, v0, p0}, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->processVariableAI(IILjava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0

    :cond_9
    aget-object v0, v8, v6

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    invoke-static {v7, v0, p0}, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->processFixedAI(IILjava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0

    :cond_a
    add-int/lit8 v5, v5, 0x1

    goto :goto_2

    :cond_b
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    if-ge v2, v7, :cond_c

    invoke-static {}, Lcom/google/zxing/NotFoundException;->getNotFoundInstance()Lcom/google/zxing/NotFoundException;

    move-result-object p0

    throw p0

    :cond_c
    invoke-virtual {p0, v0, v7}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    sget-object v3, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->FOUR_DIGIT_DATA_LENGTH:[[Ljava/lang/Object;

    array-length v4, v3

    const/4 v5, 0x0

    :goto_3
    if-ge v5, v4, :cond_f

    aget-object v8, v3, v5

    aget-object v9, v8, v0

    invoke-virtual {v9, v2}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_e

    aget-object v0, v8, v6

    sget-object v2, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->VARIABLE_LENGTH:Ljava/lang/Object;

    if-ne v0, v2, :cond_d

    aget-object v0, v8, v1

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    invoke-static {v7, v0, p0}, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->processVariableAI(IILjava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0

    :cond_d
    aget-object v0, v8, v6

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    invoke-static {v7, v0, p0}, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->processFixedAI(IILjava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0

    :cond_e
    add-int/lit8 v5, v5, 0x1

    goto :goto_3

    :cond_f
    invoke-static {}, Lcom/google/zxing/NotFoundException;->getNotFoundInstance()Lcom/google/zxing/NotFoundException;

    move-result-object p0

    throw p0
.end method

.method private static processFixedAI(IILjava/lang/String;)Ljava/lang/String;
    .locals 2

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v0

    if-ge v0, p0, :cond_0

    invoke-static {}, Lcom/google/zxing/NotFoundException;->getNotFoundInstance()Lcom/google/zxing/NotFoundException;

    move-result-object p0

    throw p0

    :cond_0
    const/4 v0, 0x0

    invoke-virtual {p2, v0, p0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v1

    add-int/2addr p1, p0

    if-ge v1, p1, :cond_1

    invoke-static {}, Lcom/google/zxing/NotFoundException;->getNotFoundInstance()Lcom/google/zxing/NotFoundException;

    move-result-object p0

    throw p0

    :cond_1
    invoke-virtual {p2, p0, p1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p2, p1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object p1

    new-instance p2, Ljava/lang/StringBuilder;

    const-string v1, "("

    invoke-direct {p2, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const/16 v0, 0x29

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    invoke-virtual {p2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p1}, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->parseFieldsInGeneralPurpose(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    if-nez p1, :cond_2

    return-object p0

    :cond_2
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private static processVariableAI(IILjava/lang/String;)Ljava/lang/String;
    .locals 2

    const/4 v0, 0x0

    invoke-virtual {p2, v0, p0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v1

    add-int/2addr p1, p0

    if-ge v1, p1, :cond_0

    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result p1

    :cond_0
    invoke-virtual {p2, p0, p1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p2, p1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object p1

    new-instance p2, Ljava/lang/StringBuilder;

    const-string v1, "("

    invoke-direct {p2, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const/16 v0, 0x29

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    invoke-virtual {p2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p1}, Lcom/google/zxing/oned/rss/expanded/decoders/FieldParser;->parseFieldsInGeneralPurpose(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    if-nez p1, :cond_1

    return-object p0

    :cond_1
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

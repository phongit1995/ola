.class Lchat/ola/vn/w/ap;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/w/bb;


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/w/bk;Lchat/ola/vn/w/cg;Lchat/ola/vn/p/g;)V
    .locals 4

    iget-wide v0, p1, Lchat/ola/vn/w/bk;->Q:J

    const-wide/16 v2, 0x0

    cmp-long p3, v2, v0

    if-eqz p3, :cond_0

    const/16 p3, 0x9

    iget-wide v0, p1, Lchat/ola/vn/w/bk;->Q:J

    invoke-virtual {p2, p3, v0, v1}, Lchat/ola/vn/w/cg;->a(SJ)V

    :cond_0
    iget-byte p3, p1, Lchat/ola/vn/w/bk;->as:B

    if-eqz p3, :cond_1

    const/16 p3, 0x72

    iget-byte v0, p1, Lchat/ola/vn/w/bk;->as:B

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/w/cg;->a(SB)V

    :cond_1
    iget-short p3, p1, Lchat/ola/vn/w/bk;->aj:S

    if-eqz p3, :cond_2

    const/16 p3, 0xff

    iget-short p1, p1, Lchat/ola/vn/w/bk;->aj:S

    int-to-byte p1, p1

    invoke-virtual {p2, p3, p1}, Lchat/ola/vn/w/cg;->a(SB)V

    :cond_2
    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 19

    move-object/from16 v6, p1

    const/4 v7, 0x0

    const/16 v0, 0xff

    invoke-virtual {v6, v0, v7}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v0

    invoke-virtual {v6, v0, v7}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v0

    int-to-short v8, v0

    const/16 v9, 0x6d

    invoke-virtual {v6, v9}, Lchat/ola/vn/w/s;->c(S)I

    move-result v10

    if-lez v10, :cond_4

    new-array v11, v10, [Lchat/ola/vn/entity/j;

    invoke-virtual {v6, v9, v7}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v0

    move v13, v0

    const/4 v12, 0x0

    :goto_0
    if-ge v12, v10, :cond_3

    invoke-virtual {v6, v9, v13}, Lchat/ola/vn/w/s;->a(SI)I

    move-result v14

    new-instance v0, Lchat/ola/vn/entity/j;

    invoke-direct {v0}, Lchat/ola/vn/entity/j;-><init>()V

    aput-object v0, v11, v12

    aget-object v0, v11, v12

    invoke-virtual {v6, v13}, Lchat/ola/vn/w/s;->c(I)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lchat/ola/vn/entity/j;->d:Ljava/lang/String;

    aget-object v0, v11, v12

    const/16 v1, 0x70

    invoke-virtual {v6, v1, v13, v14}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lchat/ola/vn/entity/j;->g:Ljava/lang/String;

    const/4 v0, 0x7

    invoke-virtual {v6, v0, v13, v14}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v15

    const/16 v0, 0x16

    invoke-virtual {v6, v0, v13, v14}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v0

    aget-object v1, v11, v12

    iput-object v15, v1, Lchat/ola/vn/entity/j;->b:Ljava/lang/String;

    aget-object v1, v11, v12

    iput-object v0, v1, Lchat/ola/vn/entity/j;->c:Ljava/lang/String;

    aget-object v4, v11, v12

    const/16 v1, 0x9

    const-wide/16 v16, 0x0

    move-object v0, v6

    move v2, v13

    move v3, v14

    move-object v9, v4

    move-wide/from16 v4, v16

    invoke-virtual/range {v0 .. v5}, Lchat/ola/vn/w/s;->a(SIIJ)J

    move-result-wide v0

    iput-wide v0, v9, Lchat/ola/vn/entity/j;->h:J

    aget-object v0, v11, v12

    const/16 v1, 0x17

    invoke-virtual {v6, v1, v13, v14}, Lchat/ola/vn/w/s;->a(SII)I

    move-result v1

    invoke-virtual {v6, v1}, Lchat/ola/vn/w/s;->b(I)[B

    move-result-object v1

    iput-object v1, v0, Lchat/ola/vn/entity/j;->i:[B

    const/16 v0, 0x6e

    invoke-virtual {v6, v0, v13, v14}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v0

    invoke-static {v15}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    invoke-static {v0}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    sget-object v1, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v0, v1}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "@"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v15}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {v15}, Ljava/lang/String;->length()I

    move-result v1

    add-int/lit8 v1, v1, 0x1

    :goto_1
    invoke-virtual {v0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    goto :goto_2

    :cond_0
    sget-object v1, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v0, v1}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v15}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-virtual {v15}, Ljava/lang/String;->length()I

    move-result v1

    goto :goto_1

    :cond_1
    :goto_2
    aget-object v1, v11, v12

    iput-object v0, v1, Lchat/ola/vn/entity/j;->e:Ljava/lang/String;

    aget-object v0, v11, v12

    const/16 v1, 0x71

    invoke-virtual {v6, v1, v13, v14}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lchat/ola/vn/entity/j;->f:Ljava/lang/String;

    const/16 v0, 0x6f

    invoke-virtual {v6, v0, v13, v14}, Lchat/ola/vn/w/s;->b(SII)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_2

    aget-object v1, v11, v12

    move-object/from16 v2, p3

    iget-object v3, v2, Lchat/ola/vn/w/ci;->f:Ljava/lang/String;

    invoke-static {v0, v3}, Lchat/ola/vn/util/o;->a(Ljava/lang/String;Ljava/lang/String;)[Lchat/ola/vn/entity/d;

    move-result-object v0

    iput-object v0, v1, Lchat/ola/vn/entity/j;->a:[Lchat/ola/vn/entity/d;

    goto :goto_3

    :cond_2
    move-object/from16 v2, p3

    :goto_3
    add-int/lit8 v12, v12, 0x1

    move v13, v14

    const/16 v9, 0x6d

    goto/16 :goto_0

    :cond_3
    const/16 v0, 0x7c

    invoke-virtual {v6, v0, v7}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v0

    invoke-virtual {v6, v0, v7}, Lchat/ola/vn/w/s;->a(II)I

    move-result v0

    move-object/from16 v1, p2

    invoke-interface {v1, v11, v0, v8}, Lchat/ola/vn/p/g;->a([Lchat/ola/vn/entity/j;IS)V

    :cond_4
    return-void
.end method

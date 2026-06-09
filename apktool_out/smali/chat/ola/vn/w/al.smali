.class public Lchat/ola/vn/w/al;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/w/bb;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/w/bk;Lchat/ola/vn/w/cg;Lchat/ola/vn/p/g;)V
    .locals 1

    iget-object p3, p1, Lchat/ola/vn/w/bk;->s:Ljava/lang/String;

    const/16 v0, 0x18

    invoke-virtual {p2, v0, p3}, Lchat/ola/vn/w/cg;->a(SLjava/lang/String;)V

    iget-short p3, p1, Lchat/ola/vn/w/bk;->aj:S

    if-eqz p3, :cond_0

    const/16 p3, 0xff

    iget-short p1, p1, Lchat/ola/vn/w/bk;->aj:S

    int-to-byte p1, p1

    invoke-virtual {p2, p3, p1}, Lchat/ola/vn/w/cg;->a(SB)V

    :cond_0
    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 16

    move-object/from16 v0, p1

    const/4 v1, 0x0

    const/16 v2, 0xff

    invoke-virtual {v0, v2, v1}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v2

    invoke-virtual {v0, v2, v1}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v2

    int-to-short v2, v2

    const/4 v3, 0x7

    invoke-virtual {v0, v3}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v3

    const/16 v4, 0x18

    invoke-virtual {v0, v4}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v4

    const/16 v5, 0x6d

    invoke-virtual {v0, v5}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v5

    const/16 v6, 0x6e

    invoke-virtual {v0, v6}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v6

    const/16 v7, 0x6f

    invoke-virtual {v0, v7}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v7

    new-instance v8, Lchat/ola/vn/entity/i;

    invoke-direct {v8}, Lchat/ola/vn/entity/i;-><init>()V

    const/16 v9, 0x71

    invoke-virtual {v0, v9}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v9

    invoke-static {v9}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v10

    if-nez v10, :cond_2

    :try_start_0
    new-instance v10, Lorg/json/JSONObject;

    invoke-direct {v10, v9}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string v9, "suggestedMedias"

    invoke-virtual {v10, v9}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v9

    if-eqz v9, :cond_2

    const-string v9, "suggestedMedias"

    invoke-virtual {v10, v9}, Lorg/json/JSONObject;->getJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v9

    invoke-virtual {v9}, Lorg/json/JSONArray;->length()I

    move-result v10

    if-lez v10, :cond_2

    new-instance v11, Ljava/util/ArrayList;

    invoke-direct {v11, v10}, Ljava/util/ArrayList;-><init>(I)V

    const/4 v12, 0x0

    :goto_0
    if-ge v12, v10, :cond_1

    invoke-virtual {v9, v12}, Lorg/json/JSONArray;->getString(I)Ljava/lang/String;

    move-result-object v13

    invoke-static {v13}, Lchat/ola/vn/entity/i;->i(Ljava/lang/String;)C

    move-result v14

    const/4 v15, 0x1

    if-ne v14, v15, :cond_0

    new-instance v14, Lchat/ola/vn/entity/i;

    invoke-direct {v14}, Lchat/ola/vn/entity/i;-><init>()V

    invoke-virtual {v14, v13}, Lchat/ola/vn/entity/i;->a(Ljava/lang/String;)V

    invoke-interface {v11, v14}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_0
    add-int/lit8 v12, v12, 0x1

    goto :goto_0

    :cond_1
    invoke-interface {v11}, Ljava/util/List;->size()I

    move-result v9

    if-lez v9, :cond_2

    invoke-virtual {v8, v11}, Lchat/ola/vn/entity/i;->a(Ljava/util/List;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    invoke-virtual {v8, v4}, Lchat/ola/vn/entity/i;->a(Ljava/lang/String;)V

    invoke-virtual {v8, v7}, Lchat/ola/vn/entity/i;->j(Ljava/lang/String;)V

    const/16 v4, 0x9

    invoke-virtual {v0, v4, v1}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v1

    const-wide/16 v9, 0x0

    invoke-virtual {v0, v1, v9, v10}, Lchat/ola/vn/w/s;->a(IJ)J

    move-result-wide v0

    cmp-long v4, v9, v0

    if-eqz v4, :cond_3

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    invoke-virtual {v8, v0}, Lchat/ola/vn/entity/i;->a(Ljava/lang/Long;)V

    :cond_3
    new-instance v0, Lchat/ola/vn/entity/l;

    invoke-direct {v0}, Lchat/ola/vn/entity/l;-><init>()V

    iput-object v5, v0, Lchat/ola/vn/entity/l;->b:Ljava/lang/String;

    iput-object v6, v0, Lchat/ola/vn/entity/l;->a:Ljava/lang/String;

    move-object/from16 v1, p2

    invoke-interface {v1, v3, v8, v0, v2}, Lchat/ola/vn/p/g;->a(Ljava/lang/String;Lchat/ola/vn/entity/i;Lchat/ola/vn/entity/l;S)V

    return-void
.end method

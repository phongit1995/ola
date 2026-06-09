.class public Lchat/ola/vn/entity/w;
.super Ljava/lang/Object;


# instance fields
.field protected a:Ljava/lang/String;

.field protected b:I

.field public c:Z

.field public d:J


# direct methods
.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/entity/w;->a:Ljava/lang/String;

    const/4 v0, 0x0

    iput v0, p0, Lchat/ola/vn/entity/w;->b:I

    iput-boolean v0, p0, Lchat/ola/vn/entity/w;->c:Z

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lchat/ola/vn/entity/w;->d:J

    return-void
.end method

.method public static a(Lorg/json/JSONObject;)Lchat/ola/vn/entity/w;
    .locals 3

    :try_start_0
    new-instance v0, Lchat/ola/vn/entity/w;

    invoke-direct {v0}, Lchat/ola/vn/entity/w;-><init>()V

    const-string v1, "stickerCode"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    const-string v1, "stickerCode"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/w;->a(Ljava/lang/String;)V

    :cond_0
    const-string v1, "kulIndex"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    const-string v1, "kulIndex"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/w;->a(I)V

    :cond_1
    const-string v1, "lastHitTime"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->getLong(Ljava/lang/String;)J

    move-result-wide v1

    iput-wide v1, v0, Lchat/ola/vn/entity/w;->d:J
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const/4 p0, 0x0

    return-object p0
.end method

.method public static b(Ljava/lang/String;)Z
    .locals 1

    :try_start_0
    const-string v0, "1P4S"

    invoke-virtual {p0, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return p0

    :catch_0
    const/4 p0, 0x0

    return p0
.end method


# virtual methods
.method public a()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entity/w;->a:Ljava/lang/String;

    return-object v0
.end method

.method public a(I)V
    .locals 0

    iput p1, p0, Lchat/ola/vn/entity/w;->b:I

    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entity/w;->a:Ljava/lang/String;

    return-void
.end method

.method public b()Lorg/json/JSONObject;
    .locals 4

    :try_start_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    iget-object v1, p0, Lchat/ola/vn/entity/w;->a:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    const-string v1, "stickerCode"

    iget-object v2, p0, Lchat/ola/vn/entity/w;->a:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    :cond_0
    iget v1, p0, Lchat/ola/vn/entity/w;->b:I

    if-lez v1, :cond_1

    const-string v1, "kulIndex"

    iget v2, p0, Lchat/ola/vn/entity/w;->b:I

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    :cond_1
    const-string v1, "lastHitTime"

    iget-wide v2, p0, Lchat/ola/vn/entity/w;->d:J

    invoke-virtual {v0, v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public c()I
    .locals 1

    iget v0, p0, Lchat/ola/vn/entity/w;->b:I

    return v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entity/w;->a:Ljava/lang/String;

    move-object v1, p1

    check-cast v1, Lchat/ola/vn/entity/w;

    iget-object v1, v1, Lchat/ola/vn/entity/w;->a:Ljava/lang/String;

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    invoke-super {p0, p1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result p1

    return p1
.end method

.class public Lchat/ola/vn/entity/ab;
.super Ljava/lang/Object;


# instance fields
.field public a:S

.field public b:B

.field public c:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x1

    iput-short v0, p0, Lchat/ola/vn/entity/ab;->a:S

    const/4 v0, 0x0

    iput-byte v0, p0, Lchat/ola/vn/entity/ab;->b:B

    return-void
.end method

.method public static a(Ljava/lang/String;)Lchat/ola/vn/entity/ab;
    .locals 2

    new-instance v0, Lchat/ola/vn/entity/ab;

    invoke-direct {v0}, Lchat/ola/vn/entity/ab;-><init>()V

    const/4 v1, 0x1

    iput-byte v1, v0, Lchat/ola/vn/entity/ab;->b:B

    iput-short v1, v0, Lchat/ola/vn/entity/ab;->a:S

    iput-object p0, v0, Lchat/ola/vn/entity/ab;->c:Ljava/lang/String;

    return-object v0
.end method

.method public static a(Lorg/json/JSONObject;)Lchat/ola/vn/entity/ab;
    .locals 2

    :try_start_0
    new-instance v0, Lchat/ola/vn/entity/ab;

    invoke-direct {v0}, Lchat/ola/vn/entity/ab;-><init>()V

    const-string v1, "type"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v1

    int-to-byte v1, v1

    iput-byte v1, v0, Lchat/ola/vn/entity/ab;->b:B

    const-string v1, "url"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lchat/ola/vn/entity/ab;->c:Ljava/lang/String;

    const/4 v1, 0x1

    iput-short v1, v0, Lchat/ola/vn/entity/ab;->a:S

    const-string v1, "mediaType"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    const-string v1, "mediaType"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result p0

    int-to-short p0, p0

    iput-short p0, v0, Lchat/ola/vn/entity/ab;->a:S
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :cond_0
    return-object v0

    :catch_0
    const/4 p0, 0x0

    return-object p0
.end method

.method public static b(Ljava/lang/String;)Lchat/ola/vn/entity/ab;
    .locals 2

    new-instance v0, Lchat/ola/vn/entity/ab;

    invoke-direct {v0}, Lchat/ola/vn/entity/ab;-><init>()V

    const/4 v1, 0x0

    iput-byte v1, v0, Lchat/ola/vn/entity/ab;->b:B

    const/4 v1, 0x1

    iput-short v1, v0, Lchat/ola/vn/entity/ab;->a:S

    iput-object p0, v0, Lchat/ola/vn/entity/ab;->c:Ljava/lang/String;

    return-object v0
.end method

.method public static c(Ljava/lang/String;)Lchat/ola/vn/entity/ab;
    .locals 2

    new-instance v0, Lchat/ola/vn/entity/ab;

    invoke-direct {v0}, Lchat/ola/vn/entity/ab;-><init>()V

    const/4 v1, 0x0

    iput-byte v1, v0, Lchat/ola/vn/entity/ab;->b:B

    const/4 v1, 0x2

    iput-short v1, v0, Lchat/ola/vn/entity/ab;->a:S

    iput-object p0, v0, Lchat/ola/vn/entity/ab;->c:Ljava/lang/String;

    return-object v0
.end method


# virtual methods
.method public a()Lorg/json/JSONObject;
    .locals 3

    :try_start_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    const-string v1, "type"

    iget-byte v2, p0, Lchat/ola/vn/entity/ab;->b:B

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    const-string v1, "mediaType"

    iget-short v2, p0, Lchat/ola/vn/entity/ab;->a:S

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    iget-object v1, p0, Lchat/ola/vn/entity/ab;->c:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    const-string v1, "url"

    iget-object v2, p0, Lchat/ola/vn/entity/ab;->c:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :cond_0
    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 3

    :try_start_0
    move-object v0, p1

    check-cast v0, Lchat/ola/vn/entity/ab;

    iget-byte v1, p0, Lchat/ola/vn/entity/ab;->b:B

    iget-byte v2, v0, Lchat/ola/vn/entity/ab;->b:B

    if-ne v1, v2, :cond_0

    iget-object v1, p0, Lchat/ola/vn/entity/ab;->c:Ljava/lang/String;

    iget-object v0, v0, Lchat/ola/vn/entity/ab;->c:Ljava/lang/String;

    invoke-static {v1, v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v0, :cond_0

    const/4 p1, 0x1

    return p1

    :catch_0
    :cond_0
    invoke-super {p0, p1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result p1

    return p1
.end method

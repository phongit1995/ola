.class public Lchat/ola/vn/entity/r;
.super Ljava/lang/Object;


# instance fields
.field public a:Ljava/lang/String;

.field public b:J

.field public c:J

.field public d:I


# direct methods
.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, ""

    iput-object v0, p0, Lchat/ola/vn/entity/r;->a:Ljava/lang/String;

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lchat/ola/vn/entity/r;->b:J

    iput-wide v0, p0, Lchat/ola/vn/entity/r;->c:J

    const/4 v0, 0x0

    iput v0, p0, Lchat/ola/vn/entity/r;->d:I

    return-void
.end method

.method public static a(Ljava/lang/String;)Lchat/ola/vn/entity/r;
    .locals 4

    new-instance v0, Lchat/ola/vn/entity/r;

    invoke-direct {v0}, Lchat/ola/vn/entity/r;-><init>()V

    :try_start_0
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, p0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string p0, "passCode"

    invoke-virtual {v1, p0}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    iput-object p0, v0, Lchat/ola/vn/entity/r;->a:Ljava/lang/String;

    const-string p0, "lastFailTime"

    invoke-virtual {v1, p0}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;)J

    move-result-wide v2

    iput-wide v2, v0, Lchat/ola/vn/entity/r;->b:J

    const-wide/16 v2, 0x0

    iput-wide v2, v0, Lchat/ola/vn/entity/r;->c:J

    const-string p0, "requirePasscodeTime"

    invoke-virtual {v1, p0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result p0

    if-eqz p0, :cond_0

    const-string p0, "requirePasscodeTime"

    invoke-virtual {v1, p0}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;)J

    move-result-wide v2

    iput-wide v2, v0, Lchat/ola/vn/entity/r;->c:J

    :cond_0
    const-string p0, "failCount"

    invoke-virtual {v1, p0}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;)I

    move-result p0

    iput p0, v0, Lchat/ola/vn/entity/r;->d:I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-object v0
.end method


# virtual methods
.method public toString()Ljava/lang/String;
    .locals 4

    :try_start_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    const-string v1, "passCode"

    iget-object v2, p0, Lchat/ola/vn/entity/r;->a:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v1, "lastFailTime"

    iget-wide v2, p0, Lchat/ola/vn/entity/r;->b:J

    invoke-virtual {v0, v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    const-string v1, "requirePasscodeTime"

    iget-wide v2, p0, Lchat/ola/vn/entity/r;->c:J

    invoke-virtual {v0, v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    const-string v1, "failCount"

    iget v2, p0, Lchat/ola/vn/entity/r;->d:I

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const-string v0, ""

    return-object v0
.end method

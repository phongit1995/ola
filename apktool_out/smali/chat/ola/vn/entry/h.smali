.class public Lchat/ola/vn/entry/h;
.super Ljava/lang/Object;


# instance fields
.field public a:J

.field public b:[Ljava/lang/String;

.field public c:S

.field public d:I

.field private e:[I


# direct methods
.method public varargs constructor <init>(IS[I)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lchat/ola/vn/entry/h;->a:J

    iput-object p3, p0, Lchat/ola/vn/entry/h;->e:[I

    iput p1, p0, Lchat/ola/vn/entry/h;->d:I

    iput-short p2, p0, Lchat/ola/vn/entry/h;->c:S

    return-void
.end method

.method public varargs constructor <init>(IS[Ljava/lang/String;)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lchat/ola/vn/entry/h;->a:J

    iput-object p3, p0, Lchat/ola/vn/entry/h;->b:[Ljava/lang/String;

    iput p1, p0, Lchat/ola/vn/entry/h;->d:I

    iput-short p2, p0, Lchat/ola/vn/entry/h;->c:S

    return-void
.end method


# virtual methods
.method public a()[I
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entry/h;->e:[I

    return-object v0
.end method

.method public b()I
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/entry/h;->e:[I

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/entry/h;->e:[I

    array-length v0, v0

    if-nez v0, :cond_0

    return v1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entry/h;->e:[I

    aget v0, v0, v1

    return v0

    :cond_1
    return v1
.end method

.method public c()Lorg/json/JSONObject;
    .locals 4

    :try_start_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    const-string v1, "smileyType"

    iget-short v2, p0, Lchat/ola/vn/entry/h;->c:S

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    iget-short v1, p0, Lchat/ola/vn/entry/h;->c:S

    const/4 v2, 0x0

    if-nez v1, :cond_0

    const-string v1, "smileyTextContent"

    iget-object v3, p0, Lchat/ola/vn/entry/h;->b:[Ljava/lang/String;

    aget-object v2, v3, v2

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto :goto_0

    :cond_0
    iget-short v1, p0, Lchat/ola/vn/entry/h;->c:S

    const/4 v3, 0x1

    if-ne v1, v3, :cond_1

    const-string v1, "emojiCode"

    iget-object v3, p0, Lchat/ola/vn/entry/h;->e:[I

    aget v2, v3, v2

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    :cond_1
    :goto_0
    const-string v1, "lastHitTime"

    iget-wide v2, p0, Lchat/ola/vn/entry/h;->a:J

    invoke-virtual {v0, v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 4

    :try_start_0
    move-object v0, p1

    check-cast v0, Lchat/ola/vn/entry/h;

    iget-short v1, p0, Lchat/ola/vn/entry/h;->c:S

    iget-short v2, v0, Lchat/ola/vn/entry/h;->c:S

    const/4 v3, 0x0

    if-eq v1, v2, :cond_0

    return v3

    :cond_0
    iget-short v1, v0, Lchat/ola/vn/entry/h;->c:S

    packed-switch v1, :pswitch_data_0

    goto :goto_0

    :pswitch_0
    invoke-virtual {p0}, Lchat/ola/vn/entry/h;->b()I

    move-result v1

    invoke-static {v1}, Ljava/lang/Character;->toChars(I)[C

    move-result-object v1

    invoke-static {v1}, Ljava/lang/String;->valueOf([C)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0}, Lchat/ola/vn/entry/h;->b()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Character;->toChars(I)[C

    move-result-object v0

    invoke-static {v0}, Ljava/lang/String;->valueOf([C)Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    return v0

    :pswitch_1
    iget-object v1, p0, Lchat/ola/vn/entry/h;->b:[Ljava/lang/String;

    aget-object v1, v1, v3

    iget-object v0, v0, Lchat/ola/vn/entry/h;->b:[Ljava/lang/String;

    aget-object v0, v0, v3

    invoke-static {v1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    :goto_0
    :pswitch_2
    invoke-super {p0, p1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result p1

    return p1

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
        :pswitch_2
    .end packed-switch
.end method

.class Lchat/ola/vn/signup/fb/d$6;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/facebook/GraphRequest$GraphJSONObjectCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/signup/fb/d;->B()Lcom/facebook/GraphRequest;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/signup/fb/d;


# direct methods
.method constructor <init>(Lchat/ola/vn/signup/fb/d;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/signup/fb/d$6;->a:Lchat/ola/vn/signup/fb/d;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCompleted(Lorg/json/JSONObject;Lcom/facebook/GraphResponse;)V
    .locals 2

    if-eqz p1, :cond_2

    :try_start_0
    const-string p2, "gender"

    invoke-virtual {p1, p2}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    const-string v0, "male"

    invoke-static {p2, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 p2, 0x1

    :goto_0
    sput-byte p2, Lchat/ola/vn/signup/fb/d;->e:B

    goto :goto_1

    :cond_0
    const-string v0, "female"

    invoke-static {p2, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz p2, :cond_1

    const/4 p2, 0x0

    goto :goto_0

    :cond_1
    const/4 p2, 0x2

    goto :goto_0

    :catch_0
    :goto_1
    :try_start_1
    const-string p2, "birthday"

    invoke-virtual {p1, p2}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/String;->toString()Ljava/lang/String;

    move-result-object p1

    new-instance p2, Ljava/text/SimpleDateFormat;

    const-string v0, "MM/dd/yyyy"

    sget-object v1, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-direct {p2, v0, v1}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    invoke-virtual {p2, p1}, Ljava/text/SimpleDateFormat;->parse(Ljava/lang/String;)Ljava/util/Date;

    move-result-object p1

    invoke-virtual {p1}, Ljava/util/Date;->getTime()J

    move-result-wide p1

    sput-wide p1, Lchat/ola/vn/signup/fb/d;->d:J
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    return-void

    :catch_1
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_2
    return-void
.end method

.class Lchat/ola/vn/c$a;
.super Landroid/os/AsyncTask;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/c;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroid/os/AsyncTask<",
        "Ljava/lang/String;",
        "Ljava/lang/Void;",
        "Ljava/lang/String;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/c;


# direct methods
.method private constructor <init>(Lchat/ola/vn/c;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/c$a;->a:Lchat/ola/vn/c;

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lchat/ola/vn/c;Lchat/ola/vn/c$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/c$a;-><init>(Lchat/ola/vn/c;)V

    return-void
.end method

.method private b(Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    new-instance p1, Ljava/util/HashMap;

    invoke-direct {p1}, Ljava/util/HashMap;-><init>()V

    const-string v0, "fields"

    const-string v1, "ip,ms,acckit,facebook,peighttexst,peightcarsd"

    invoke-interface {p1, v0, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "id/pubinfo"

    const/4 v1, 0x0

    const/4 v2, 0x0

    invoke-static {v1, v0, p1, v2}, Lchat/ola/vn/util/http/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Z)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method


# virtual methods
.method protected varargs a([Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    :try_start_0
    sget-object p1, Lchat/ola/vn/h;->g:Ljava/lang/String;

    invoke-direct {p0, p1}, Lchat/ola/vn/c$a;->b(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/http/a;->e(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string p1, "country"

    invoke-virtual {v0, p1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    const-string p1, "country"

    invoke-virtual {v0, p1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/c;->e(Ljava/lang/String;)Ljava/lang/String;

    invoke-static {}, Lchat/ola/vn/c;->A()Ljava/lang/String;

    move-result-object p1

    sget-object v1, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {p1, v1}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/c;->e(Ljava/lang/String;)Ljava/lang/String;

    :cond_0
    const-string p1, "peighttexst"

    invoke-virtual {v0, p1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_1

    const-string p1, "peighttexst"

    invoke-virtual {v0, p1}, Lorg/json/JSONObject;->getBoolean(Ljava/lang/String;)Z

    move-result p1

    sput-boolean p1, Lchat/ola/vn/h;->a:Z

    :cond_1
    const-string p1, "peightcarsd"

    invoke-virtual {v0, p1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_2

    const-string p1, "peightcarsd"

    invoke-virtual {v0, p1}, Lorg/json/JSONObject;->getBoolean(Ljava/lang/String;)Z

    move-result p1

    sput-boolean p1, Lchat/ola/vn/h;->b:Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_2
    :goto_0
    const/4 p1, 0x0

    return-object p1
.end method

.method protected a(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method protected synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p1, [Ljava/lang/String;

    invoke-virtual {p0, p1}, Lchat/ola/vn/c$a;->a([Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method protected synthetic onPostExecute(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Ljava/lang/String;

    invoke-virtual {p0, p1}, Lchat/ola/vn/c$a;->a(Ljava/lang/String;)V

    return-void
.end method

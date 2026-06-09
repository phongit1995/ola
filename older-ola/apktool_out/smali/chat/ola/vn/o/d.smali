.class public Lchat/ola/vn/o/d;
.super Lchat/ola/vn/entry/e;


# direct methods
.method public constructor <init>()V
    .locals 2

    const v0, 0x7f0f00f4

    const v1, 0x7f08079a

    invoke-direct {p0, v0, v1, v0}, Lchat/ola/vn/entry/e;-><init>(III)V

    const-string v0, "osimi.chat.ola.vn"

    iput-object v0, p0, Lchat/ola/vn/o/d;->h:Ljava/lang/String;

    const/4 v0, 0x0

    iput v0, p0, Lchat/ola/vn/o/d;->i:I

    const/4 v0, 0x1

    iput v0, p0, Lchat/ola/vn/o/d;->g:I

    return-void
.end method


# virtual methods
.method public b(Landroid/content/Context;)Z
    .locals 2

    :try_start_0
    const-string v0, "osimi"

    const v1, 0x7f0f00f4

    invoke-virtual {p1, v1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {p1, v0, v1}, Lchat/ola/vn/m/m;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/4 p1, 0x1

    return p1

    :catch_0
    const/4 p1, 0x0

    return p1
.end method

.method public h()Ljava/lang/String;
    .locals 1

    const v0, 0x7f0f0571

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/o/d;->j:Ljava/lang/String;

    invoke-super {p0}, Lchat/ola/vn/entry/e;->h()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

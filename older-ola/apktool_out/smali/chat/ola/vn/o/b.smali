.class public Lchat/ola/vn/o/b;
.super Lchat/ola/vn/entry/e;


# direct methods
.method public constructor <init>(I)V
    .locals 3

    const v0, 0x7f0f00dd

    const v1, 0x7f080791

    invoke-direct {p0, v0, v1, v0}, Lchat/ola/vn/entry/e;-><init>(III)V

    const-string v0, "birthday.ola.vn"

    iput-object v0, p0, Lchat/ola/vn/o/b;->h:Ljava/lang/String;

    const/4 v0, 0x1

    iput v0, p0, Lchat/ola/vn/o/b;->i:I

    iput v0, p0, Lchat/ola/vn/o/b;->g:I

    if-lez p1, :cond_0

    const/4 v0, 0x2

    iput v0, p0, Lchat/ola/vn/o/b;->g:I

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lchat/ola/vn/o/b;->d:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    int-to-long v1, p1

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, ")"

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/o/b;->d:Ljava/lang/String;

    :cond_0
    return-void
.end method


# virtual methods
.method public b(Landroid/content/Context;)Z
    .locals 0

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/activity/OlaBirthdayCheerActivity;->a(Landroid/content/Context;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/4 p1, 0x1

    return p1

    :catch_0
    const/4 p1, 0x0

    return p1
.end method

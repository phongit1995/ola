.class public Lchat/ola/vn/s/a;
.super Landroid/os/FileObserver;


# instance fields
.field private a:Lchat/ola/vn/s/b;

.field private b:Z

.field private c:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 1

    const/16 v0, 0x100

    invoke-direct {p0, p1, v0}, Landroid/os/FileObserver;-><init>(Ljava/lang/String;I)V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/s/a;->b:Z

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/s/a;->c:Ljava/lang/String;

    iput-object p1, p0, Lchat/ola/vn/s/a;->c:Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/s/a;->c:Ljava/lang/String;

    const-string v0, "/"

    invoke-virtual {p1, v0}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_0

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v0, p0, Lchat/ola/vn/s/a;->c:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, "/"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/s/a;->c:Ljava/lang/String;

    :cond_0
    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/s/b;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/s/a;->a:Lchat/ola/vn/s/b;

    return-void
.end method

.method public onEvent(ILjava/lang/String;)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/s/a;->c:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lchat/ola/vn/s/a;->c:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    :cond_0
    const/16 v0, 0x40

    if-eq p1, v0, :cond_5

    const/16 v0, 0x100

    if-eq p1, v0, :cond_1

    const/16 v0, 0x200

    if-eq p1, v0, :cond_5

    return-void

    :cond_1
    iget-boolean p1, p0, Lchat/ola/vn/s/a;->b:Z

    if-eqz p1, :cond_4

    :try_start_0
    new-instance p1, Ljava/io/File;

    invoke-direct {p1, p2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/io/File;->delete()Z

    move-result p1

    if-eqz p1, :cond_2

    return-void

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/s/a;->a:Lchat/ola/vn/s/b;

    if-eqz p1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/s/a;->a:Lchat/ola/vn/s/b;

    invoke-interface {p1, p2}, Lchat/ola/vn/s/b;->A(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    iget-object p1, p0, Lchat/ola/vn/s/a;->a:Lchat/ola/vn/s/b;

    if-eqz p1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/s/a;->a:Lchat/ola/vn/s/b;

    invoke-interface {p1, p2}, Lchat/ola/vn/s/b;->A(Ljava/lang/String;)V

    :cond_3
    return-void

    :cond_4
    iget-object p1, p0, Lchat/ola/vn/s/a;->a:Lchat/ola/vn/s/b;

    if-eqz p1, :cond_6

    iget-object p1, p0, Lchat/ola/vn/s/a;->a:Lchat/ola/vn/s/b;

    invoke-interface {p1, p2}, Lchat/ola/vn/s/b;->A(Ljava/lang/String;)V

    return-void

    :cond_5
    iget-object p1, p0, Lchat/ola/vn/s/a;->a:Lchat/ola/vn/s/b;

    if-eqz p1, :cond_6

    iget-object p1, p0, Lchat/ola/vn/s/a;->a:Lchat/ola/vn/s/b;

    invoke-interface {p1, p2}, Lchat/ola/vn/s/b;->B(Ljava/lang/String;)V

    :cond_6
    return-void
.end method

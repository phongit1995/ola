.class Lchat/ola/vn/entry/b/ac$1;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/p/l;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/entry/b/ac;->f()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entry/b/ac;


# direct methods
.method constructor <init>(Lchat/ola/vn/entry/b/ac;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/b/ac$1;->a:Lchat/ola/vn/entry/b/ac;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/entity/u;)V
    .locals 3

    :try_start_0
    new-instance v0, Lchat/ola/vn/entity/z;

    invoke-direct {v0}, Lchat/ola/vn/entity/z;-><init>()V

    invoke-static {v0}, Lchat/ola/vn/entry/b/ac;->a(Lchat/ola/vn/entity/z;)Lchat/ola/vn/entity/z;

    invoke-static {}, Lchat/ola/vn/entry/b/ac;->e()Lchat/ola/vn/entity/z;

    move-result-object v0

    invoke-virtual {p1}, Lchat/ola/vn/entity/u;->c()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lchat/ola/vn/entity/z;->c:Ljava/lang/String;

    invoke-static {}, Lchat/ola/vn/entry/b/ac;->e()Lchat/ola/vn/entity/z;

    move-result-object v0

    const/4 v1, 0x0

    iput-object v1, v0, Lchat/ola/vn/entity/z;->e:Ljava/lang/String;

    invoke-static {}, Lchat/ola/vn/entry/b/ac;->e()Lchat/ola/vn/entity/z;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "rss://"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Lchat/ola/vn/entity/u;->g()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lchat/ola/vn/entity/z;->a:Ljava/lang/String;

    invoke-static {}, Lchat/ola/vn/entry/b/ac;->e()Lchat/ola/vn/entity/z;

    move-result-object v0

    invoke-virtual {p1}, Lchat/ola/vn/entity/u;->d()Ljava/lang/String;

    move-result-object p1

    iput-object p1, v0, Lchat/ola/vn/entity/z;->f:Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/entry/b/ac$1;->a:Lchat/ola/vn/entry/b/ac;

    invoke-virtual {p1}, Lchat/ola/vn/entry/b/ac;->a()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(SLjava/lang/String;)V
    .locals 0

    const/4 p1, 0x0

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/entry/b/ac;->a(Lchat/ola/vn/entity/z;)Lchat/ola/vn/entity/z;

    iget-object p1, p0, Lchat/ola/vn/entry/b/ac$1;->a:Lchat/ola/vn/entry/b/ac;

    invoke-virtual {p1}, Lchat/ola/vn/entry/b/ac;->a()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

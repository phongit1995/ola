.class Lchat/ola/vn/m/t$8;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/b/j$a;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/t;->b(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/t;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/t;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/t$8;->a:Lchat/ola/vn/m/t;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public B()Z
    .locals 2

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/m/t$8;->a:Lchat/ola/vn/m/t;

    iget-object v1, v1, Lchat/ola/vn/m/t;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v1}, Lchat/ola/vn/entity/e;->k()Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/m/t$8;->a:Lchat/ola/vn/m/t;

    iget-object v1, v1, Lchat/ola/vn/m/t;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v1}, Lchat/ola/vn/entity/e;->h()Ljava/lang/String;

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v1, :cond_0

    const/4 v0, 0x1

    :catch_0
    :cond_0
    return v0
.end method

.method public a_(I)V
    .locals 1

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/m/t$8;->a:Lchat/ola/vn/m/t;

    iget-object v0, p0, Lchat/ola/vn/m/t$8;->a:Lchat/ola/vn/m/t;

    iget-object v0, v0, Lchat/ola/vn/m/t;->a:Lchat/ola/vn/entity/e;

    invoke-static {p1, v0}, Lchat/ola/vn/m/t;->a(Lchat/ola/vn/m/t;Lchat/ola/vn/entity/e;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

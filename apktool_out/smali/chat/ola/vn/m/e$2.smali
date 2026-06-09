.class Lchat/ola/vn/m/e$2;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/e;->a(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:S

.field final synthetic b:Landroid/os/Bundle;

.field final synthetic c:Lchat/ola/vn/m/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/e;SLandroid/os/Bundle;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/e$2;->c:Lchat/ola/vn/m/e;

    iput-short p2, p0, Lchat/ola/vn/m/e$2;->a:S

    iput-object p3, p0, Lchat/ola/vn/m/e$2;->b:Landroid/os/Bundle;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/m/e$2;->c:Lchat/ola/vn/m/e;

    iget-short v1, p0, Lchat/ola/vn/m/e$2;->a:S

    iget-object v2, p0, Lchat/ola/vn/m/e$2;->b:Landroid/os/Bundle;

    invoke-static {v0, v1, v2}, Lchat/ola/vn/m/e;->a(Lchat/ola/vn/m/e;SLandroid/os/Bundle;)V

    iget-object v0, p0, Lchat/ola/vn/m/e$2;->c:Lchat/ola/vn/m/e;

    invoke-static {v0}, Lchat/ola/vn/m/e;->a(Lchat/ola/vn/m/e;)V

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/e$2;->c:Lchat/ola/vn/m/e;

    iget-short v1, p0, Lchat/ola/vn/m/e$2;->a:S

    invoke-static {v0, v1}, Lchat/ola/vn/m/e;->a(Lchat/ola/vn/m/e;I)Lchat/ola/vn/m/p;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/m/p;->h()V

    iget-object v0, p0, Lchat/ola/vn/m/e$2;->c:Lchat/ola/vn/m/e;

    invoke-virtual {v0}, Lchat/ola/vn/m/e;->e()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

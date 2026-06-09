.class Lchat/ola/vn/m/r$8$2;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/r$8;->a(Ljava/lang/String;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/r$8;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/r$8;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/r$8$2;->a:Lchat/ola/vn/m/r$8;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/r$8$2;->a:Lchat/ola/vn/m/r$8;

    iget-object v0, v0, Lchat/ola/vn/m/r$8;->a:Lchat/ola/vn/entity/e;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->e(Z)V

    iget-object v0, p0, Lchat/ola/vn/m/r$8$2;->a:Lchat/ola/vn/m/r$8;

    iget-object v0, v0, Lchat/ola/vn/m/r$8;->a:Lchat/ola/vn/entity/e;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->b(Z)V

    iget-object v0, p0, Lchat/ola/vn/m/r$8$2;->a:Lchat/ola/vn/m/r$8;

    iget-object v0, v0, Lchat/ola/vn/m/r$8;->b:Lchat/ola/vn/m/r;

    invoke-static {v0}, Lchat/ola/vn/m/r;->d(Lchat/ola/vn/m/r;)Landroid/view/View;

    move-result-object v0

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

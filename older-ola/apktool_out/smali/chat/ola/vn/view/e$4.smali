.class Lchat/ola/vn/view/e$4;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/view/e;->a(Landroid/graphics/SurfaceTexture;II)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/view/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/view/e;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/e$4;->a:Lchat/ola/vn/view/e;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/view/e$4;->a:Lchat/ola/vn/view/e;

    invoke-virtual {v0}, Lchat/ola/vn/view/e;->getContext()Landroid/content/Context;

    move-result-object v0

    const v1, 0x7f010024

    invoke-static {v0, v1}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/view/e$4;->a:Lchat/ola/vn/view/e;

    invoke-static {v1}, Lchat/ola/vn/view/e;->g(Lchat/ola/vn/view/e;)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/view/View;->startAnimation(Landroid/view/animation/Animation;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    iget-object v0, p0, Lchat/ola/vn/view/e$4;->a:Lchat/ola/vn/view/e;

    invoke-static {v0}, Lchat/ola/vn/view/e;->g(Lchat/ola/vn/view/e;)Landroid/view/View;

    move-result-object v0

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method

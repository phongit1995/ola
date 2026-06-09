.class Lchat/ola/vn/balloon/d$2;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/animation/Animation$AnimationListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/balloon/d;->f()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/balloon/d;


# direct methods
.method constructor <init>(Lchat/ola/vn/balloon/d;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/balloon/d$2;->a:Lchat/ola/vn/balloon/d;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAnimationEnd(Landroid/view/animation/Animation;)V
    .locals 1

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/balloon/d$2;->a:Lchat/ola/vn/balloon/d;

    iget-object v0, p0, Lchat/ola/vn/balloon/d$2;->a:Lchat/ola/vn/balloon/d;

    invoke-static {v0}, Lchat/ola/vn/balloon/d;->a(Lchat/ola/vn/balloon/d;)Landroid/widget/ImageView;

    move-result-object v0

    invoke-virtual {p1, v0}, Lchat/ola/vn/balloon/d;->removeView(Landroid/view/View;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onAnimationRepeat(Landroid/view/animation/Animation;)V
    .locals 0

    return-void
.end method

.method public onAnimationStart(Landroid/view/animation/Animation;)V
    .locals 0

    return-void
.end method

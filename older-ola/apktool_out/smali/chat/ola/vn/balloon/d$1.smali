.class Lchat/ola/vn/balloon/d$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/animation/Animation$AnimationListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/balloon/d;->e()V
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

    iput-object p1, p0, Lchat/ola/vn/balloon/d$1;->a:Lchat/ola/vn/balloon/d;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAnimationEnd(Landroid/view/animation/Animation;)V
    .locals 2

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/balloon/d$1;->a:Lchat/ola/vn/balloon/d;

    invoke-static {p1}, Lchat/ola/vn/balloon/d;->a(Lchat/ola/vn/balloon/d;)Landroid/widget/ImageView;

    move-result-object p1

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/balloon/d$1;->a:Lchat/ola/vn/balloon/d;

    iget-object v0, p0, Lchat/ola/vn/balloon/d$1;->a:Lchat/ola/vn/balloon/d;

    invoke-static {v0}, Lchat/ola/vn/balloon/d;->a(Lchat/ola/vn/balloon/d;)Landroid/widget/ImageView;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/balloon/d$1;->a:Lchat/ola/vn/balloon/d;

    iget-object v1, v1, Lchat/ola/vn/balloon/d;->c:Landroid/widget/RelativeLayout$LayoutParams;

    invoke-virtual {p1, v0, v1}, Lchat/ola/vn/balloon/d;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    iget-object p1, p0, Lchat/ola/vn/balloon/d$1;->a:Lchat/ola/vn/balloon/d;

    invoke-virtual {p1}, Lchat/ola/vn/balloon/d;->getContext()Landroid/content/Context;

    move-result-object p1

    const v0, 0x7f01004b

    invoke-static {p1, v0}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p1

    const-wide/16 v0, 0x12c

    invoke-virtual {p1, v0, v1}, Landroid/view/animation/Animation;->setDuration(J)V

    new-instance v0, Lchat/ola/vn/balloon/d$1$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/balloon/d$1$1;-><init>(Lchat/ola/vn/balloon/d$1;)V

    invoke-virtual {p1, v0}, Landroid/view/animation/Animation;->setAnimationListener(Landroid/view/animation/Animation$AnimationListener;)V

    iget-object v0, p0, Lchat/ola/vn/balloon/d$1;->a:Lchat/ola/vn/balloon/d;

    invoke-static {v0}, Lchat/ola/vn/balloon/d;->a(Lchat/ola/vn/balloon/d;)Landroid/widget/ImageView;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/widget/ImageView;->startAnimation(Landroid/view/animation/Animation;)V
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

.class Lchat/ola/vn/c$7;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/animation/Animation$AnimationListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/c;->a(IILandroid/widget/FrameLayout;IJJ)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Landroid/widget/ImageView;

.field final synthetic b:Landroid/widget/FrameLayout;

.field final synthetic c:Lchat/ola/vn/c;


# direct methods
.method constructor <init>(Lchat/ola/vn/c;Landroid/widget/ImageView;Landroid/widget/FrameLayout;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/c$7;->c:Lchat/ola/vn/c;

    iput-object p2, p0, Lchat/ola/vn/c$7;->a:Landroid/widget/ImageView;

    iput-object p3, p0, Lchat/ola/vn/c$7;->b:Landroid/widget/FrameLayout;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAnimationEnd(Landroid/view/animation/Animation;)V
    .locals 1

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/c$7;->a:Landroid/widget/ImageView;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setVisibility(I)V

    new-instance p1, Lchat/ola/vn/c$7$1;

    invoke-direct {p1, p0}, Lchat/ola/vn/c$7$1;-><init>(Lchat/ola/vn/c$7;)V

    invoke-static {p1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V
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

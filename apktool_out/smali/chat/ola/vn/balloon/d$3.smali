.class Lchat/ola/vn/balloon/d$3;
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

    iput-object p1, p0, Lchat/ola/vn/balloon/d$3;->a:Lchat/ola/vn/balloon/d;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAnimationEnd(Landroid/view/animation/Animation;)V
    .locals 1

    iget-object p1, p0, Lchat/ola/vn/balloon/d$3;->a:Lchat/ola/vn/balloon/d;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Lchat/ola/vn/balloon/d;->setVisibility(I)V

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

.class Lchat/ola/vn/view/e$2;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/animation/Animator$AnimatorListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/view/e;->onClick(Landroid/view/View;)V
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

    iput-object p1, p0, Lchat/ola/vn/view/e$2;->a:Lchat/ola/vn/view/e;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAnimationCancel(Landroid/animation/Animator;)V
    .locals 0

    return-void
.end method

.method public onAnimationEnd(Landroid/animation/Animator;)V
    .locals 1

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/view/e$2;->a:Lchat/ola/vn/view/e;

    invoke-static {p1}, Lchat/ola/vn/view/e;->d(Lchat/ola/vn/view/e;)Landroid/view/View;

    move-result-object p1

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/view/e$2;->a:Lchat/ola/vn/view/e;

    invoke-virtual {p1}, Lchat/ola/vn/view/e;->c()Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/view/e$2;->a:Lchat/ola/vn/view/e;

    invoke-virtual {p1}, Lchat/ola/vn/view/e;->e()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public onAnimationRepeat(Landroid/animation/Animator;)V
    .locals 0

    return-void
.end method

.method public onAnimationStart(Landroid/animation/Animator;)V
    .locals 0

    return-void
.end method

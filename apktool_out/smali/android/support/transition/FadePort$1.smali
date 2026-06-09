.class Landroid/support/transition/FadePort$1;
.super Landroid/support/transition/TransitionPort$TransitionListenerAdapter;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Landroid/support/transition/FadePort;->onAppear(Landroid/view/ViewGroup;Landroid/support/transition/TransitionValues;ILandroid/support/transition/TransitionValues;I)Landroid/animation/Animator;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field mCanceled:Z

.field mPausedAlpha:F

.field final synthetic this$0:Landroid/support/transition/FadePort;

.field final synthetic val$endView:Landroid/view/View;


# direct methods
.method constructor <init>(Landroid/support/transition/FadePort;Landroid/view/View;)V
    .locals 0

    iput-object p1, p0, Landroid/support/transition/FadePort$1;->this$0:Landroid/support/transition/FadePort;

    iput-object p2, p0, Landroid/support/transition/FadePort$1;->val$endView:Landroid/view/View;

    invoke-direct {p0}, Landroid/support/transition/TransitionPort$TransitionListenerAdapter;-><init>()V

    const/4 p1, 0x0

    iput-boolean p1, p0, Landroid/support/transition/FadePort$1;->mCanceled:Z

    return-void
.end method


# virtual methods
.method public onTransitionCancel(Landroid/support/transition/TransitionPort;)V
    .locals 1

    iget-object p1, p0, Landroid/support/transition/FadePort$1;->val$endView:Landroid/view/View;

    const/high16 v0, 0x3f800000    # 1.0f

    invoke-virtual {p1, v0}, Landroid/view/View;->setAlpha(F)V

    const/4 p1, 0x1

    iput-boolean p1, p0, Landroid/support/transition/FadePort$1;->mCanceled:Z

    return-void
.end method

.method public onTransitionEnd(Landroid/support/transition/TransitionPort;)V
    .locals 1

    iget-boolean p1, p0, Landroid/support/transition/FadePort$1;->mCanceled:Z

    if-nez p1, :cond_0

    iget-object p1, p0, Landroid/support/transition/FadePort$1;->val$endView:Landroid/view/View;

    const/high16 v0, 0x3f800000    # 1.0f

    invoke-virtual {p1, v0}, Landroid/view/View;->setAlpha(F)V

    :cond_0
    return-void
.end method

.method public onTransitionPause(Landroid/support/transition/TransitionPort;)V
    .locals 1

    iget-object p1, p0, Landroid/support/transition/FadePort$1;->val$endView:Landroid/view/View;

    invoke-virtual {p1}, Landroid/view/View;->getAlpha()F

    move-result p1

    iput p1, p0, Landroid/support/transition/FadePort$1;->mPausedAlpha:F

    iget-object p1, p0, Landroid/support/transition/FadePort$1;->val$endView:Landroid/view/View;

    const/high16 v0, 0x3f800000    # 1.0f

    invoke-virtual {p1, v0}, Landroid/view/View;->setAlpha(F)V

    return-void
.end method

.method public onTransitionResume(Landroid/support/transition/TransitionPort;)V
    .locals 1

    iget-object p1, p0, Landroid/support/transition/FadePort$1;->val$endView:Landroid/view/View;

    iget v0, p0, Landroid/support/transition/FadePort$1;->mPausedAlpha:F

    invoke-virtual {p1, v0}, Landroid/view/View;->setAlpha(F)V

    return-void
.end method

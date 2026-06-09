.class Landroid/support/transition/FadePort$2;
.super Landroid/animation/AnimatorListenerAdapter;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Landroid/support/transition/FadePort;->onDisappear(Landroid/view/ViewGroup;Landroid/support/transition/TransitionValues;ILandroid/support/transition/TransitionValues;I)Landroid/animation/Animator;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Landroid/support/transition/FadePort;

.field final synthetic val$finalOverlayView:Landroid/view/View;

.field final synthetic val$finalSceneRoot:Landroid/view/ViewGroup;

.field final synthetic val$finalView:Landroid/view/View;

.field final synthetic val$finalViewToKeep:Landroid/view/View;

.field final synthetic val$finalVisibility:I


# direct methods
.method constructor <init>(Landroid/support/transition/FadePort;Landroid/view/View;Landroid/view/View;ILandroid/view/View;Landroid/view/ViewGroup;)V
    .locals 0

    iput-object p1, p0, Landroid/support/transition/FadePort$2;->this$0:Landroid/support/transition/FadePort;

    iput-object p2, p0, Landroid/support/transition/FadePort$2;->val$finalView:Landroid/view/View;

    iput-object p3, p0, Landroid/support/transition/FadePort$2;->val$finalViewToKeep:Landroid/view/View;

    iput p4, p0, Landroid/support/transition/FadePort$2;->val$finalVisibility:I

    iput-object p5, p0, Landroid/support/transition/FadePort$2;->val$finalOverlayView:Landroid/view/View;

    iput-object p6, p0, Landroid/support/transition/FadePort$2;->val$finalSceneRoot:Landroid/view/ViewGroup;

    invoke-direct {p0}, Landroid/animation/AnimatorListenerAdapter;-><init>()V

    return-void
.end method


# virtual methods
.method public onAnimationEnd(Landroid/animation/Animator;)V
    .locals 1

    iget-object p1, p0, Landroid/support/transition/FadePort$2;->val$finalView:Landroid/view/View;

    const/high16 v0, 0x3f800000    # 1.0f

    invoke-virtual {p1, v0}, Landroid/view/View;->setAlpha(F)V

    iget-object p1, p0, Landroid/support/transition/FadePort$2;->val$finalViewToKeep:Landroid/view/View;

    if-eqz p1, :cond_0

    iget-object p1, p0, Landroid/support/transition/FadePort$2;->val$finalViewToKeep:Landroid/view/View;

    iget v0, p0, Landroid/support/transition/FadePort$2;->val$finalVisibility:I

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    :cond_0
    iget-object p1, p0, Landroid/support/transition/FadePort$2;->val$finalOverlayView:Landroid/view/View;

    if-eqz p1, :cond_1

    iget-object p1, p0, Landroid/support/transition/FadePort$2;->val$finalSceneRoot:Landroid/view/ViewGroup;

    invoke-static {p1}, Landroid/support/transition/ViewGroupOverlay;->createFrom(Landroid/view/ViewGroup;)Landroid/support/transition/ViewGroupOverlay;

    move-result-object p1

    iget-object v0, p0, Landroid/support/transition/FadePort$2;->val$finalOverlayView:Landroid/view/View;

    invoke-virtual {p1, v0}, Landroid/support/transition/ViewGroupOverlay;->remove(Landroid/view/View;)V

    :cond_1
    return-void
.end method

.class Landroid/support/design/widget/FloatingActionButtonGingerbread$2;
.super Landroid/support/design/widget/AnimationUtils$AnimationListenerAdapter;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Landroid/support/design/widget/FloatingActionButtonGingerbread;->show(Landroid/support/design/widget/FloatingActionButtonImpl$InternalVisibilityChangedListener;Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Landroid/support/design/widget/FloatingActionButtonGingerbread;

.field final synthetic val$listener:Landroid/support/design/widget/FloatingActionButtonImpl$InternalVisibilityChangedListener;


# direct methods
.method constructor <init>(Landroid/support/design/widget/FloatingActionButtonGingerbread;Landroid/support/design/widget/FloatingActionButtonImpl$InternalVisibilityChangedListener;)V
    .locals 0

    iput-object p1, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread$2;->this$0:Landroid/support/design/widget/FloatingActionButtonGingerbread;

    iput-object p2, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread$2;->val$listener:Landroid/support/design/widget/FloatingActionButtonImpl$InternalVisibilityChangedListener;

    invoke-direct {p0}, Landroid/support/design/widget/AnimationUtils$AnimationListenerAdapter;-><init>()V

    return-void
.end method


# virtual methods
.method public onAnimationEnd(Landroid/view/animation/Animation;)V
    .locals 1

    iget-object p1, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread$2;->this$0:Landroid/support/design/widget/FloatingActionButtonGingerbread;

    const/4 v0, 0x0

    iput v0, p1, Landroid/support/design/widget/FloatingActionButtonGingerbread;->mAnimState:I

    iget-object p1, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread$2;->val$listener:Landroid/support/design/widget/FloatingActionButtonImpl$InternalVisibilityChangedListener;

    if-eqz p1, :cond_0

    iget-object p1, p0, Landroid/support/design/widget/FloatingActionButtonGingerbread$2;->val$listener:Landroid/support/design/widget/FloatingActionButtonImpl$InternalVisibilityChangedListener;

    invoke-interface {p1}, Landroid/support/design/widget/FloatingActionButtonImpl$InternalVisibilityChangedListener;->onShown()V

    :cond_0
    return-void
.end method

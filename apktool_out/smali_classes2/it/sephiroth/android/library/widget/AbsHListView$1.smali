.class Lit/sephiroth/android/library/widget/AbsHListView$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lit/sephiroth/android/library/widget/AbsHListView;->onTouchEvent(Landroid/view/MotionEvent;)Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Landroid/view/View;

.field final synthetic b:Lit/sephiroth/android/library/widget/AbsHListView$i;

.field final synthetic c:Lit/sephiroth/android/library/widget/AbsHListView;


# direct methods
.method constructor <init>(Lit/sephiroth/android/library/widget/AbsHListView;Landroid/view/View;Lit/sephiroth/android/library/widget/AbsHListView$i;)V
    .locals 0

    iput-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView$1;->c:Lit/sephiroth/android/library/widget/AbsHListView;

    iput-object p2, p0, Lit/sephiroth/android/library/widget/AbsHListView$1;->a:Landroid/view/View;

    iput-object p3, p0, Lit/sephiroth/android/library/widget/AbsHListView$1;->b:Lit/sephiroth/android/library/widget/AbsHListView$i;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$1;->c:Lit/sephiroth/android/library/widget/AbsHListView;

    const/4 v1, -0x1

    iput v1, v0, Lit/sephiroth/android/library/widget/AbsHListView;->F:I

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$1;->a:Landroid/view/View;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/View;->setPressed(Z)V

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$1;->c:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v0, v1}, Lit/sephiroth/android/library/widget/AbsHListView;->setPressed(Z)V

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$1;->c:Lit/sephiroth/android/library/widget/AbsHListView;

    iget-boolean v0, v0, Lit/sephiroth/android/library/widget/AbsHListView;->aj:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$1;->b:Lit/sephiroth/android/library/widget/AbsHListView$i;

    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/AbsHListView$i;->run()V

    :cond_0
    return-void
.end method

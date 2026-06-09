.class Lit/sephiroth/android/library/widget/AbsHListView$b;
.super Lit/sephiroth/android/library/widget/AbsHListView$n;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lit/sephiroth/android/library/widget/AbsHListView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "b"
.end annotation


# instance fields
.field final synthetic a:Lit/sephiroth/android/library/widget/AbsHListView;


# direct methods
.method private constructor <init>(Lit/sephiroth/android/library/widget/AbsHListView;)V
    .locals 1

    iput-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView$b;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lit/sephiroth/android/library/widget/AbsHListView$n;-><init>(Lit/sephiroth/android/library/widget/AbsHListView;Lit/sephiroth/android/library/widget/AbsHListView$1;)V

    return-void
.end method

.method synthetic constructor <init>(Lit/sephiroth/android/library/widget/AbsHListView;Lit/sephiroth/android/library/widget/AbsHListView$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lit/sephiroth/android/library/widget/AbsHListView$b;-><init>(Lit/sephiroth/android/library/widget/AbsHListView;)V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$b;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/AbsHListView;->isPressed()Z

    move-result v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$b;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget v0, v0, Lit/sephiroth/android/library/widget/AbsHListView;->am:I

    if-ltz v0, :cond_2

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$b;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget v0, v0, Lit/sephiroth/android/library/widget/AbsHListView;->am:I

    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView$b;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget v1, v1, Lit/sephiroth/android/library/widget/AbsHListView;->V:I

    sub-int/2addr v0, v1

    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView$b;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v1, v0}, Lit/sephiroth/android/library/widget/AbsHListView;->getChildAt(I)Landroid/view/View;

    move-result-object v0

    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView$b;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget-boolean v1, v1, Lit/sephiroth/android/library/widget/AbsHListView;->aj:Z

    const/4 v2, 0x0

    if-nez v1, :cond_1

    invoke-virtual {p0}, Lit/sephiroth/android/library/widget/AbsHListView$b;->b()Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView$b;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget-object v3, p0, Lit/sephiroth/android/library/widget/AbsHListView$b;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget v3, v3, Lit/sephiroth/android/library/widget/AbsHListView;->am:I

    iget-object v4, p0, Lit/sephiroth/android/library/widget/AbsHListView$b;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    iget-wide v4, v4, Lit/sephiroth/android/library/widget/AbsHListView;->an:J

    invoke-virtual {v1, v0, v3, v4, v5}, Lit/sephiroth/android/library/widget/AbsHListView;->c(Landroid/view/View;IJ)Z

    move-result v1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    if-eqz v1, :cond_2

    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView$b;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v1, v2}, Lit/sephiroth/android/library/widget/AbsHListView;->setPressed(Z)V

    goto :goto_1

    :cond_1
    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView$b;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v1, v2}, Lit/sephiroth/android/library/widget/AbsHListView;->setPressed(Z)V

    if-eqz v0, :cond_2

    :goto_1
    invoke-virtual {v0, v2}, Landroid/view/View;->setPressed(Z)V

    :cond_2
    return-void
.end method

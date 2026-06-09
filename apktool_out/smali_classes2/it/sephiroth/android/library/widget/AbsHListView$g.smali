.class Lit/sephiroth/android/library/widget/AbsHListView$g;
.super Landroid/support/v4/view/AccessibilityDelegateCompat;


# annotations
.annotation build Landroid/annotation/TargetApi;
    value = 0xe
.end annotation

.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lit/sephiroth/android/library/widget/AbsHListView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "g"
.end annotation


# instance fields
.field final synthetic a:Lit/sephiroth/android/library/widget/AbsHListView;


# direct methods
.method constructor <init>(Lit/sephiroth/android/library/widget/AbsHListView;)V
    .locals 0

    iput-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView$g;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-direct {p0}, Landroid/support/v4/view/AccessibilityDelegateCompat;-><init>()V

    return-void
.end method


# virtual methods
.method public onInitializeAccessibilityNodeInfo(Landroid/view/View;Landroid/support/v4/view/accessibility/AccessibilityNodeInfoCompat;)V
    .locals 2

    invoke-super {p0, p1, p2}, Landroid/support/v4/view/AccessibilityDelegateCompat;->onInitializeAccessibilityNodeInfo(Landroid/view/View;Landroid/support/v4/view/accessibility/AccessibilityNodeInfoCompat;)V

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$g;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v0, p1}, Lit/sephiroth/android/library/widget/AbsHListView;->a(Landroid/view/View;)I

    move-result p1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$g;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/AbsHListView;->getAdapter()Landroid/widget/Adapter;

    move-result-object v0

    check-cast v0, Landroid/widget/ListAdapter;

    const/4 v1, -0x1

    if-eq p1, v1, :cond_4

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView$g;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v1}, Lit/sephiroth/android/library/widget/AbsHListView;->isEnabled()Z

    move-result v1

    if-eqz v1, :cond_4

    invoke-interface {v0, p1}, Landroid/widget/ListAdapter;->isEnabled(I)Z

    move-result v0

    if-nez v0, :cond_1

    return-void

    :cond_1
    iget-object v0, p0, Lit/sephiroth/android/library/widget/AbsHListView$g;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/AbsHListView;->getSelectedItemPosition()I

    move-result v0

    const/4 v1, 0x1

    if-ne p1, v0, :cond_2

    invoke-virtual {p2, v1}, Landroid/support/v4/view/accessibility/AccessibilityNodeInfoCompat;->setSelected(Z)V

    const/16 p1, 0x8

    :goto_0
    invoke-virtual {p2, p1}, Landroid/support/v4/view/accessibility/AccessibilityNodeInfoCompat;->addAction(I)V

    goto :goto_1

    :cond_2
    const/4 p1, 0x4

    goto :goto_0

    :goto_1
    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView$g;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {p1}, Lit/sephiroth/android/library/widget/AbsHListView;->isClickable()Z

    move-result p1

    if-eqz p1, :cond_3

    const/16 p1, 0x10

    invoke-virtual {p2, p1}, Landroid/support/v4/view/accessibility/AccessibilityNodeInfoCompat;->addAction(I)V

    invoke-virtual {p2, v1}, Landroid/support/v4/view/accessibility/AccessibilityNodeInfoCompat;->setClickable(Z)V

    :cond_3
    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView$g;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {p1}, Lit/sephiroth/android/library/widget/AbsHListView;->isLongClickable()Z

    move-result p1

    if-eqz p1, :cond_4

    const/16 p1, 0x20

    invoke-virtual {p2, p1}, Landroid/support/v4/view/accessibility/AccessibilityNodeInfoCompat;->addAction(I)V

    invoke-virtual {p2, v1}, Landroid/support/v4/view/accessibility/AccessibilityNodeInfoCompat;->setLongClickable(Z)V

    :cond_4
    return-void
.end method

.method public performAccessibilityAction(Landroid/view/View;ILandroid/os/Bundle;)Z
    .locals 6

    invoke-super {p0, p1, p2, p3}, Landroid/support/v4/view/AccessibilityDelegateCompat;->performAccessibilityAction(Landroid/view/View;ILandroid/os/Bundle;)Z

    move-result p3

    const/4 v0, 0x1

    if-eqz p3, :cond_0

    return v0

    :cond_0
    iget-object p3, p0, Lit/sephiroth/android/library/widget/AbsHListView$g;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {p3, p1}, Lit/sephiroth/android/library/widget/AbsHListView;->a(Landroid/view/View;)I

    move-result p3

    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView$g;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v1}, Lit/sephiroth/android/library/widget/AbsHListView;->getAdapter()Landroid/widget/Adapter;

    move-result-object v1

    check-cast v1, Landroid/widget/ListAdapter;

    const/4 v2, -0x1

    const/4 v3, 0x0

    if-eq p3, v2, :cond_a

    if-nez v1, :cond_1

    return v3

    :cond_1
    iget-object v4, p0, Lit/sephiroth/android/library/widget/AbsHListView$g;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v4}, Lit/sephiroth/android/library/widget/AbsHListView;->isEnabled()Z

    move-result v4

    if-eqz v4, :cond_a

    invoke-interface {v1, p3}, Landroid/widget/ListAdapter;->isEnabled(I)Z

    move-result v1

    if-nez v1, :cond_2

    return v3

    :cond_2
    iget-object v1, p0, Lit/sephiroth/android/library/widget/AbsHListView$g;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {v1, p3}, Lit/sephiroth/android/library/widget/AbsHListView;->g(I)J

    move-result-wide v4

    const/4 v1, 0x4

    if-eq p2, v1, :cond_9

    const/16 v1, 0x8

    if-eq p2, v1, :cond_7

    const/16 v0, 0x10

    if-eq p2, v0, :cond_5

    const/16 v0, 0x20

    if-eq p2, v0, :cond_3

    return v3

    :cond_3
    iget-object p2, p0, Lit/sephiroth/android/library/widget/AbsHListView$g;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {p2}, Lit/sephiroth/android/library/widget/AbsHListView;->isLongClickable()Z

    move-result p2

    if-eqz p2, :cond_4

    iget-object p2, p0, Lit/sephiroth/android/library/widget/AbsHListView$g;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {p2, p1, p3, v4, v5}, Lit/sephiroth/android/library/widget/AbsHListView;->c(Landroid/view/View;IJ)Z

    move-result p1

    return p1

    :cond_4
    return v3

    :cond_5
    iget-object p2, p0, Lit/sephiroth/android/library/widget/AbsHListView$g;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {p2}, Lit/sephiroth/android/library/widget/AbsHListView;->isClickable()Z

    move-result p2

    if-eqz p2, :cond_6

    iget-object p2, p0, Lit/sephiroth/android/library/widget/AbsHListView$g;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {p2, p1, p3, v4, v5}, Lit/sephiroth/android/library/widget/AbsHListView;->a(Landroid/view/View;IJ)Z

    move-result p1

    return p1

    :cond_6
    return v3

    :cond_7
    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView$g;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {p1}, Lit/sephiroth/android/library/widget/AbsHListView;->getSelectedItemPosition()I

    move-result p1

    if-ne p1, p3, :cond_8

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView$g;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {p1, v2}, Lit/sephiroth/android/library/widget/AbsHListView;->setSelection(I)V

    return v0

    :cond_8
    return v3

    :cond_9
    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView$g;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {p1}, Lit/sephiroth/android/library/widget/AbsHListView;->getSelectedItemPosition()I

    move-result p1

    if-eq p1, p3, :cond_a

    iget-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView$g;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-virtual {p1, p3}, Lit/sephiroth/android/library/widget/AbsHListView;->setSelection(I)V

    return v0

    :cond_a
    return v3
.end method

.class Lit/sephiroth/android/library/widget/EnhancedListView$e;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lit/sephiroth/android/library/widget/EnhancedListView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "e"
.end annotation


# instance fields
.field final synthetic a:Lit/sephiroth/android/library/widget/EnhancedListView;


# direct methods
.method private constructor <init>(Lit/sephiroth/android/library/widget/EnhancedListView;)V
    .locals 0

    iput-object p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView$e;->a:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lit/sephiroth/android/library/widget/EnhancedListView;Lit/sephiroth/android/library/widget/EnhancedListView$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lit/sephiroth/android/library/widget/EnhancedListView$e;-><init>(Lit/sephiroth/android/library/widget/EnhancedListView;)V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    iget-object p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView$e;->a:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-static {p1}, Lit/sephiroth/android/library/widget/EnhancedListView;->a(Lit/sephiroth/android/library/widget/EnhancedListView;)Ljava/util/List;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/List;->isEmpty()Z

    move-result p1

    if-nez p1, :cond_1

    sget-object p1, Lit/sephiroth/android/library/widget/EnhancedListView$6;->a:[I

    iget-object v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView$e;->a:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-static {v0}, Lit/sephiroth/android/library/widget/EnhancedListView;->b(Lit/sephiroth/android/library/widget/EnhancedListView;)Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;

    move-result-object v0

    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;->ordinal()I

    move-result v0

    aget p1, p1, v0

    packed-switch p1, :pswitch_data_0

    goto :goto_1

    :pswitch_0
    iget-object p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView$e;->a:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-static {p1}, Lit/sephiroth/android/library/widget/EnhancedListView;->a(Lit/sephiroth/android/library/widget/EnhancedListView;)Ljava/util/List;

    move-result-object p1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView$e;->a:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-static {v0}, Lit/sephiroth/android/library/widget/EnhancedListView;->a(Lit/sephiroth/android/library/widget/EnhancedListView;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    invoke-interface {p1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lit/sephiroth/android/library/widget/EnhancedListView$f;

    invoke-virtual {p1}, Lit/sephiroth/android/library/widget/EnhancedListView$f;->a()V

    iget-object p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView$e;->a:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-static {p1}, Lit/sephiroth/android/library/widget/EnhancedListView;->a(Lit/sephiroth/android/library/widget/EnhancedListView;)Ljava/util/List;

    move-result-object p1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView$e;->a:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-static {v0}, Lit/sephiroth/android/library/widget/EnhancedListView;->a(Lit/sephiroth/android/library/widget/EnhancedListView;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    invoke-interface {p1, v0}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    goto :goto_1

    :pswitch_1
    iget-object p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView$e;->a:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-static {p1}, Lit/sephiroth/android/library/widget/EnhancedListView;->a(Lit/sephiroth/android/library/widget/EnhancedListView;)Ljava/util/List;

    move-result-object p1

    invoke-static {p1}, Ljava/util/Collections;->reverse(Ljava/util/List;)V

    iget-object p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView$e;->a:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-static {p1}, Lit/sephiroth/android/library/widget/EnhancedListView;->a(Lit/sephiroth/android/library/widget/EnhancedListView;)Ljava/util/List;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lit/sephiroth/android/library/widget/EnhancedListView$f;

    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/EnhancedListView$f;->a()V

    goto :goto_0

    :pswitch_2
    iget-object p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView$e;->a:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-static {p1}, Lit/sephiroth/android/library/widget/EnhancedListView;->a(Lit/sephiroth/android/library/widget/EnhancedListView;)Ljava/util/List;

    move-result-object p1

    const/4 v0, 0x0

    invoke-interface {p1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lit/sephiroth/android/library/widget/EnhancedListView$f;

    invoke-virtual {p1}, Lit/sephiroth/android/library/widget/EnhancedListView$f;->a()V

    :cond_0
    iget-object p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView$e;->a:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-static {p1}, Lit/sephiroth/android/library/widget/EnhancedListView;->a(Lit/sephiroth/android/library/widget/EnhancedListView;)Ljava/util/List;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/List;->clear()V

    :cond_1
    :goto_1
    iget-object p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView$e;->a:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-static {p1}, Lit/sephiroth/android/library/widget/EnhancedListView;->a(Lit/sephiroth/android/library/widget/EnhancedListView;)Ljava/util/List;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/List;->isEmpty()Z

    move-result p1

    if-eqz p1, :cond_2

    iget-object p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView$e;->a:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-static {p1}, Lit/sephiroth/android/library/widget/EnhancedListView;->c(Lit/sephiroth/android/library/widget/EnhancedListView;)Landroid/widget/PopupWindow;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/PopupWindow;->isShowing()Z

    move-result p1

    if-eqz p1, :cond_3

    iget-object p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView$e;->a:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-static {p1}, Lit/sephiroth/android/library/widget/EnhancedListView;->c(Lit/sephiroth/android/library/widget/EnhancedListView;)Landroid/widget/PopupWindow;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/PopupWindow;->dismiss()V

    goto :goto_2

    :cond_2
    iget-object p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView$e;->a:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-static {p1}, Lit/sephiroth/android/library/widget/EnhancedListView;->d(Lit/sephiroth/android/library/widget/EnhancedListView;)V

    iget-object p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView$e;->a:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-static {p1}, Lit/sephiroth/android/library/widget/EnhancedListView;->e(Lit/sephiroth/android/library/widget/EnhancedListView;)V

    :cond_3
    :goto_2
    iget-object p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView$e;->a:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-static {p1}, Lit/sephiroth/android/library/widget/EnhancedListView;->f(Lit/sephiroth/android/library/widget/EnhancedListView;)I

    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

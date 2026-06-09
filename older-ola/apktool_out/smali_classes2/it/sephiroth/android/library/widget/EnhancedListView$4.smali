.class Lit/sephiroth/android/library/widget/EnhancedListView$4;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/mg/ola/a/a/b/n$b;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lit/sephiroth/android/library/widget/EnhancedListView;->a(Landroid/view/View;Landroid/view/View;I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Landroid/view/ViewGroup$LayoutParams;

.field final synthetic b:Landroid/view/View;

.field final synthetic c:Lit/sephiroth/android/library/widget/EnhancedListView;


# direct methods
.method constructor <init>(Lit/sephiroth/android/library/widget/EnhancedListView;Landroid/view/ViewGroup$LayoutParams;Landroid/view/View;)V
    .locals 0

    iput-object p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView$4;->c:Lit/sephiroth/android/library/widget/EnhancedListView;

    iput-object p2, p0, Lit/sephiroth/android/library/widget/EnhancedListView$4;->a:Landroid/view/ViewGroup$LayoutParams;

    iput-object p3, p0, Lit/sephiroth/android/library/widget/EnhancedListView$4;->b:Landroid/view/View;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lcom/mg/ola/a/a/b/n;)V
    .locals 1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView$4;->a:Landroid/view/ViewGroup$LayoutParams;

    invoke-virtual {p1}, Lcom/mg/ola/a/a/b/n;->l()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/Integer;

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    iput p1, v0, Landroid/view/ViewGroup$LayoutParams;->height:I

    iget-object p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView$4;->b:Landroid/view/View;

    iget-object v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView$4;->a:Landroid/view/ViewGroup$LayoutParams;

    invoke-virtual {p1, v0}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    return-void
.end method

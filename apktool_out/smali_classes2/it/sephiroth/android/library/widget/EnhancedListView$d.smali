.class Lit/sephiroth/android/library/widget/EnhancedListView$d;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Comparable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lit/sephiroth/android/library/widget/EnhancedListView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "d"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Ljava/lang/Comparable<",
        "Lit/sephiroth/android/library/widget/EnhancedListView$d;",
        ">;"
    }
.end annotation


# instance fields
.field public a:I

.field public b:Landroid/view/View;

.field public c:Landroid/view/View;

.field final synthetic d:Lit/sephiroth/android/library/widget/EnhancedListView;


# direct methods
.method constructor <init>(Lit/sephiroth/android/library/widget/EnhancedListView;ILandroid/view/View;Landroid/view/View;)V
    .locals 0

    iput-object p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView$d;->d:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p2, p0, Lit/sephiroth/android/library/widget/EnhancedListView$d;->a:I

    iput-object p3, p0, Lit/sephiroth/android/library/widget/EnhancedListView$d;->b:Landroid/view/View;

    iput-object p4, p0, Lit/sephiroth/android/library/widget/EnhancedListView$d;->c:Landroid/view/View;

    return-void
.end method


# virtual methods
.method public a(Lit/sephiroth/android/library/widget/EnhancedListView$d;)I
    .locals 1

    iget p1, p1, Lit/sephiroth/android/library/widget/EnhancedListView$d;->a:I

    iget v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView$d;->a:I

    sub-int/2addr p1, v0

    return p1
.end method

.method public synthetic compareTo(Ljava/lang/Object;)I
    .locals 0

    check-cast p1, Lit/sephiroth/android/library/widget/EnhancedListView$d;

    invoke-virtual {p0, p1}, Lit/sephiroth/android/library/widget/EnhancedListView$d;->a(Lit/sephiroth/android/library/widget/EnhancedListView$d;)I

    move-result p1

    return p1
.end method

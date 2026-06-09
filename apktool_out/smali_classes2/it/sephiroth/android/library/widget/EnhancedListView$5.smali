.class Lit/sephiroth/android/library/widget/EnhancedListView$5;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AbsListView$OnScrollListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lit/sephiroth/android/library/widget/EnhancedListView;->e()Landroid/widget/AbsListView$OnScrollListener;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lit/sephiroth/android/library/widget/EnhancedListView;


# direct methods
.method constructor <init>(Lit/sephiroth/android/library/widget/EnhancedListView;)V
    .locals 0

    iput-object p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView$5;->a:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onScroll(Landroid/widget/AbsListView;III)V
    .locals 0

    return-void
.end method

.method public onScrollStateChanged(Landroid/widget/AbsListView;I)V
    .locals 1

    iget-object p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView$5;->a:Lit/sephiroth/android/library/widget/EnhancedListView;

    const/4 v0, 0x1

    if-ne p2, v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    invoke-static {p1, v0}, Lit/sephiroth/android/library/widget/EnhancedListView;->a(Lit/sephiroth/android/library/widget/EnhancedListView;Z)Z

    return-void
.end method

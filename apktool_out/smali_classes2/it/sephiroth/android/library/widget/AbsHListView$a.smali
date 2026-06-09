.class public Lit/sephiroth/android/library/widget/AbsHListView$a;
.super Lit/sephiroth/android/library/widget/a$b;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lit/sephiroth/android/library/widget/AbsHListView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "a"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lit/sephiroth/android/library/widget/a<",
        "Landroid/widget/ListAdapter;",
        ">.b;"
    }
.end annotation


# instance fields
.field final synthetic a:Lit/sephiroth/android/library/widget/AbsHListView;


# direct methods
.method public constructor <init>(Lit/sephiroth/android/library/widget/AbsHListView;)V
    .locals 0

    iput-object p1, p0, Lit/sephiroth/android/library/widget/AbsHListView$a;->a:Lit/sephiroth/android/library/widget/AbsHListView;

    invoke-direct {p0, p1}, Lit/sephiroth/android/library/widget/a$b;-><init>(Lit/sephiroth/android/library/widget/a;)V

    return-void
.end method


# virtual methods
.method public onChanged()V
    .locals 0

    invoke-super {p0}, Lit/sephiroth/android/library/widget/a$b;->onChanged()V

    return-void
.end method

.method public onInvalidated()V
    .locals 0

    invoke-super {p0}, Lit/sephiroth/android/library/widget/a$b;->onInvalidated()V

    return-void
.end method

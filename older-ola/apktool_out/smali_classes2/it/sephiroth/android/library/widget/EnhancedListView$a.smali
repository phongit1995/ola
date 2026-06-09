.class Lit/sephiroth/android/library/widget/EnhancedListView$a;
.super Landroid/os/Handler;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lit/sephiroth/android/library/widget/EnhancedListView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field final synthetic a:Lit/sephiroth/android/library/widget/EnhancedListView;


# direct methods
.method private constructor <init>(Lit/sephiroth/android/library/widget/EnhancedListView;)V
    .locals 0

    iput-object p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView$a;->a:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lit/sephiroth/android/library/widget/EnhancedListView;Lit/sephiroth/android/library/widget/EnhancedListView$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lit/sephiroth/android/library/widget/EnhancedListView$a;-><init>(Lit/sephiroth/android/library/widget/EnhancedListView;)V

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 1

    iget p1, p1, Landroid/os/Message;->what:I

    iget-object v0, p0, Lit/sephiroth/android/library/widget/EnhancedListView$a;->a:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-static {v0}, Lit/sephiroth/android/library/widget/EnhancedListView;->g(Lit/sephiroth/android/library/widget/EnhancedListView;)I

    move-result v0

    if-ne p1, v0, :cond_0

    iget-object p1, p0, Lit/sephiroth/android/library/widget/EnhancedListView$a;->a:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-virtual {p1}, Lit/sephiroth/android/library/widget/EnhancedListView;->b()V

    :cond_0
    return-void
.end method

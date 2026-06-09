.class Lit/sephiroth/android/library/widget/a$f;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lit/sephiroth/android/library/widget/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "f"
.end annotation


# instance fields
.field final synthetic a:Lit/sephiroth/android/library/widget/a;


# direct methods
.method private constructor <init>(Lit/sephiroth/android/library/widget/a;)V
    .locals 0

    iput-object p1, p0, Lit/sephiroth/android/library/widget/a$f;->a:Lit/sephiroth/android/library/widget/a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lit/sephiroth/android/library/widget/a;Lit/sephiroth/android/library/widget/a$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lit/sephiroth/android/library/widget/a$f;-><init>(Lit/sephiroth/android/library/widget/a;)V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/a$f;->a:Lit/sephiroth/android/library/widget/a;

    iget-boolean v0, v0, Lit/sephiroth/android/library/widget/a;->aj:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lit/sephiroth/android/library/widget/a$f;->a:Lit/sephiroth/android/library/widget/a;

    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/a;->getAdapter()Landroid/widget/Adapter;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lit/sephiroth/android/library/widget/a$f;->a:Lit/sephiroth/android/library/widget/a;

    invoke-virtual {v0, p0}, Lit/sephiroth/android/library/widget/a;->post(Ljava/lang/Runnable;)Z

    return-void

    :cond_0
    iget-object v0, p0, Lit/sephiroth/android/library/widget/a$f;->a:Lit/sephiroth/android/library/widget/a;

    invoke-static {v0}, Lit/sephiroth/android/library/widget/a;->b(Lit/sephiroth/android/library/widget/a;)V

    iget-object v0, p0, Lit/sephiroth/android/library/widget/a$f;->a:Lit/sephiroth/android/library/widget/a;

    invoke-static {v0}, Lit/sephiroth/android/library/widget/a;->c(Lit/sephiroth/android/library/widget/a;)V

    :cond_1
    return-void
.end method

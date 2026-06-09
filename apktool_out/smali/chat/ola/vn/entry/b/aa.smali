.class public Lchat/ola/vn/entry/b/aa;
.super Lchat/ola/vn/entry/b/j;


# static fields
.field public static l:Z = true


# instance fields
.field i:Landroid/view/View;

.field j:Lit/sephiroth/android/library/widget/HListView;

.field k:Lchat/ola/vn/b/w;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/entry/b/j;-><init>()V

    return-void
.end method

.method private e()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/aa;->a:Landroid/view/View$OnClickListener;

    if-eqz v0, :cond_0

    new-instance v0, Lchat/ola/vn/entry/b/aa$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/entry/b/aa$1;-><init>(Lchat/ola/vn/entry/b/aa;)V

    iget-object v1, p0, Lchat/ola/vn/entry/b/aa;->i:Landroid/view/View;

    invoke-virtual {v1, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/aa;->k:Lchat/ola/vn/b/w;

    iget-object v1, p0, Lchat/ola/vn/entry/b/aa;->a:Landroid/view/View$OnClickListener;

    invoke-virtual {v0, v1}, Lchat/ola/vn/b/w;->a(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/aa;->k:Lchat/ola/vn/b/w;

    iget-object v1, p0, Lchat/ola/vn/entry/b/aa;->e:Landroid/view/View$OnLongClickListener;

    invoke-virtual {v0, v1}, Lchat/ola/vn/b/w;->a(Landroid/view/View$OnLongClickListener;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method


# virtual methods
.method public a()V
    .locals 2
    .annotation build Landroid/annotation/TargetApi;
        value = 0xb
    .end annotation

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/aa;->b:Lchat/ola/vn/entry/b;

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/entry/b/aa;->e()V

    sget-boolean v0, Lchat/ola/vn/entry/b/aa;->l:Z

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/entry/b/aa;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    iget-object v0, v0, Lchat/ola/vn/entity/g;->d:Ljava/util/List;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/entry/b/aa;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    iget-object v0, v0, Lchat/ola/vn/entity/g;->d:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/entry/b/aa;->k:Lchat/ola/vn/b/w;

    iget-object v1, p0, Lchat/ola/vn/entry/b/aa;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    iget-object v1, v1, Lchat/ola/vn/entity/g;->d:Ljava/util/List;

    invoke-virtual {v0, v1}, Lchat/ola/vn/b/w;->a(Ljava/util/List;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/aa;->j:Lit/sephiroth/android/library/widget/HListView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lit/sephiroth/android/library/widget/HListView;->c(I)V

    sput-boolean v1, Lchat/ola/vn/entry/b/aa;->l:Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method

.method public a(Landroid/view/View;)V
    .locals 1

    invoke-super {p0, p1}, Lchat/ola/vn/entry/b/j;->a(Landroid/view/View;)V

    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Landroid/view/View;->setClickable(Z)V

    sput-boolean v0, Lchat/ola/vn/entry/b/aa;->l:Z

    const v0, 0x7f0905e7

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entry/b/aa;->i:Landroid/view/View;

    const v0, 0x7f0904a8

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lit/sephiroth/android/library/widget/HListView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/aa;->j:Lit/sephiroth/android/library/widget/HListView;

    :try_start_0
    new-instance v0, Lchat/ola/vn/b/w;

    invoke-virtual {p1}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object p1

    invoke-direct {v0, p1}, Lchat/ola/vn/b/w;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/entry/b/aa;->k:Lchat/ola/vn/b/w;

    iget-object p1, p0, Lchat/ola/vn/entry/b/aa;->j:Lit/sephiroth/android/library/widget/HListView;

    iget-object v0, p0, Lchat/ola/vn/entry/b/aa;->k:Lchat/ola/vn/b/w;

    invoke-virtual {p1, v0}, Lit/sephiroth/android/library/widget/HListView;->setAdapter(Landroid/widget/ListAdapter;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Z)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/entry/b/j;->a(Z)V

    return-void
.end method

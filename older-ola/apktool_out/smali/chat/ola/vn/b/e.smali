.class public abstract Lchat/ola/vn/b/e;
.super Lchat/ola/vn/b/h;


# instance fields
.field private g:Landroid/view/View;

.field private h:I


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    invoke-direct {p0, p1}, Lchat/ola/vn/b/h;-><init>(Landroid/content/Context;)V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/b/e;->g:Landroid/view/View;

    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    const v0, 0x7f070141

    invoke-virtual {p1, v0}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result p1

    iput p1, p0, Lchat/ola/vn/b/e;->h:I

    return-void
.end method

.method private a(Lchat/ola/vn/view/OlaCachedImageView;)V
    .locals 2

    if-eqz p1, :cond_0

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1, p1}, Lchat/ola/vn/c/t;->g(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V

    :cond_0
    return-void
.end method


# virtual methods
.method public a(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 3

    if-nez p1, :cond_2

    if-nez p2, :cond_0

    iget-object p1, p0, Lchat/ola/vn/b/e;->a:Landroid/view/LayoutInflater;

    const p2, 0x7f0b00d6

    const/4 v0, 0x0

    invoke-virtual {p1, p2, p3, v0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/b/e;->g:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/b/e;->g:Landroid/view/View;

    const p2, 0x7f09028a

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/view/OlaCachedImageView;

    invoke-direct {p0, p1}, Lchat/ola/vn/b/e;->a(Lchat/ola/vn/view/OlaCachedImageView;)V

    iget-object p1, p0, Lchat/ola/vn/b/e;->g:Landroid/view/View;

    const p2, 0x7f09053e

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/EditText;

    new-instance p2, Lchat/ola/vn/b/e$1;

    invoke-direct {p2, p0, p1}, Lchat/ola/vn/b/e$1;-><init>(Lchat/ola/vn/b/e;Landroid/widget/EditText;)V

    invoke-virtual {p1, p2}, Landroid/widget/EditText;->setOnEditorActionListener(Landroid/widget/TextView$OnEditorActionListener;)V

    iget-object p1, p0, Lchat/ola/vn/b/e;->g:Landroid/view/View;

    return-object p1

    :cond_0
    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/b/e;->g:Landroid/view/View;

    const v1, 0x7f0902f6

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    invoke-virtual {p0}, Lchat/ola/vn/b/e;->getCount()I

    move-result v1

    const/4 v2, 0x1

    if-ne v1, v2, :cond_1

    const v1, 0x7f0800cf

    :goto_0
    invoke-virtual {v0, v1}, Landroid/view/View;->setBackgroundResource(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :cond_1
    const v1, 0x7f0800ac

    goto :goto_0

    :catch_0
    :cond_2
    :goto_1
    invoke-super {p0, p1, p2, p3}, Lchat/ola/vn/b/h;->a(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    return-object p1
.end method

.method public a(I)Lchat/ola/vn/entry/b;
    .locals 1

    add-int/lit8 p1, p1, -0x1

    const/4 v0, 0x0

    invoke-static {v0, p1}, Ljava/lang/Math;->max(II)I

    move-result p1

    invoke-super {p0, p1}, Lchat/ola/vn/b/h;->a(I)Lchat/ola/vn/entry/b;

    move-result-object p1

    return-object p1
.end method

.method protected a(ILchat/ola/vn/entry/b/j;Lchat/ola/vn/entry/b;)V
    .locals 1

    invoke-virtual {p0}, Lchat/ola/vn/b/e;->getCount()I

    move-result p3

    add-int/lit8 p3, p3, -0x1

    if-ne p1, p3, :cond_0

    const p1, 0x7f0800a9

    :goto_0
    invoke-virtual {p2, p1}, Lchat/ola/vn/entry/b/j;->a(I)V

    goto :goto_1

    :cond_0
    const p1, 0x7f0800a8

    goto :goto_0

    :goto_1
    iget p1, p0, Lchat/ola/vn/b/e;->h:I

    iget p3, p0, Lchat/ola/vn/b/e;->h:I

    const/4 v0, 0x0

    invoke-virtual {p2, p1, v0, p3, v0}, Lchat/ola/vn/entry/b/j;->a(IIII)V

    return-void
.end method

.method protected abstract a(Ljava/lang/String;Landroid/widget/EditText;)V
.end method

.method public getCount()I
    .locals 1

    invoke-super {p0}, Lchat/ola/vn/b/h;->getCount()I

    move-result v0

    add-int/lit8 v0, v0, 0x1

    return v0
.end method

.method public synthetic getItem(I)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/b/e;->a(I)Lchat/ola/vn/entry/b;

    move-result-object p1

    return-object p1
.end method

.method public getItemViewType(I)I
    .locals 0

    if-nez p1, :cond_0

    invoke-super {p0}, Lchat/ola/vn/b/h;->getViewTypeCount()I

    move-result p1

    return p1

    :cond_0
    invoke-super {p0, p1}, Lchat/ola/vn/b/h;->getItemViewType(I)I

    move-result p1

    return p1
.end method

.method public getViewTypeCount()I
    .locals 1

    invoke-super {p0}, Lchat/ola/vn/b/h;->getViewTypeCount()I

    move-result v0

    add-int/lit8 v0, v0, 0x1

    return v0
.end method

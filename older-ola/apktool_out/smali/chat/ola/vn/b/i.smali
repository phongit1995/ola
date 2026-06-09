.class public Lchat/ola/vn/b/i;
.super Lchat/ola/vn/b/j;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/b/i$a;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/b/j<",
        "Lchat/ola/vn/entry/e;",
        ">;"
    }
.end annotation


# instance fields
.field private a:Landroid/view/LayoutInflater;

.field private b:I


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    invoke-direct {p0, p1}, Lchat/ola/vn/b/j;-><init>(Landroid/content/Context;)V

    const-string v0, "layout_inflater"

    invoke-virtual {p1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/LayoutInflater;

    iput-object v0, p0, Lchat/ola/vn/b/i;->a:Landroid/view/LayoutInflater;

    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    const v0, 0x7f070103

    invoke-virtual {p1, v0}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result p1

    iput p1, p0, Lchat/ola/vn/b/i;->b:I

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/b/i;)I
    .locals 0

    iget p0, p0, Lchat/ola/vn/b/i;->b:I

    return p0
.end method

.method static synthetic a(Lchat/ola/vn/b/i;Ljava/lang/String;I)Ljava/lang/String;
    .locals 0

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/b/i;->a(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private a(Ljava/lang/String;I)Ljava/lang/String;
    .locals 1

    const-string v0, "?"

    invoke-virtual {p1, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, "&w="

    :goto_0
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    return-object p1

    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, "?w="

    goto :goto_0

    return-object p1
.end method


# virtual methods
.method public a(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 6

    :try_start_0
    invoke-virtual {p0, p1}, Lchat/ola/vn/b/i;->a(I)Lchat/ola/vn/entry/e;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_3

    add-int/lit8 v1, p1, -0x1

    const/4 v2, 0x0

    :try_start_1
    invoke-virtual {p0, v1}, Lchat/ola/vn/b/i;->a(I)Lchat/ola/vn/entry/e;

    move-result-object v1
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :catch_0
    move-object v1, v2

    :goto_0
    add-int/lit8 v3, p1, 0x1

    :try_start_2
    invoke-virtual {p0, v3}, Lchat/ola/vn/b/i;->a(I)Lchat/ola/vn/entry/e;

    move-result-object v3
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_1

    :catch_1
    move-object v3, v2

    :goto_1
    if-nez p2, :cond_1

    :try_start_3
    new-instance v4, Lchat/ola/vn/b/i$a;

    invoke-direct {v4, p0}, Lchat/ola/vn/b/i$a;-><init>(Lchat/ola/vn/b/i;)V

    invoke-virtual {p0, p1}, Lchat/ola/vn/b/i;->getItemViewType(I)I

    move-result p1

    if-nez p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/b/i;->a:Landroid/view/LayoutInflater;

    const v5, 0x7f0b00ba

    invoke-virtual {p1, v5, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_3

    const p2, 0x7f090096

    :try_start_4
    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, v4, Lchat/ola/vn/b/i$a;->h:Landroid/view/View;

    const p2, 0x7f090383

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    iput-object p2, v4, Lchat/ola/vn/b/i$a;->g:Landroid/view/View;

    const p2, 0x7f09037d

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object p2, v4, Lchat/ola/vn/b/i$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    const p2, 0x7f090382

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, v4, Lchat/ola/vn/b/i$a;->d:Landroid/widget/TextView;

    const p2, 0x7f090381

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, v4, Lchat/ola/vn/b/i$a;->c:Landroid/widget/TextView;

    const p2, 0x7f09037f

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, v4, Lchat/ola/vn/b/i$a;->e:Landroid/widget/TextView;

    const p2, 0x7f09037c

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, v4, Lchat/ola/vn/b/i$a;->f:Landroid/widget/TextView;

    const p2, 0x7f09037e

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/ProgressBar;

    iput-object p2, v4, Lchat/ola/vn/b/i$a;->b:Landroid/widget/ProgressBar;
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_2

    goto :goto_2

    :catch_2
    move-object p2, p1

    goto :goto_4

    :cond_0
    :try_start_5
    iget-object p1, p0, Lchat/ola/vn/b/i;->a:Landroid/view/LayoutInflater;

    const v5, 0x7f0b00cf

    invoke-virtual {p1, v5, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_3

    const p2, 0x7f0902ca

    :try_start_6
    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, v4, Lchat/ola/vn/b/i$a;->d:Landroid/widget/TextView;
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_2

    :goto_2
    move-object p2, p1

    :try_start_7
    invoke-virtual {p2, v4}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    goto :goto_3

    :cond_1
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    move-object v4, p1

    check-cast v4, Lchat/ola/vn/b/i$a;

    :goto_3
    invoke-virtual {v4, v0, v1, v3}, Lchat/ola/vn/b/i$a;->a(Lchat/ola/vn/entry/e;Lchat/ola/vn/entry/e;Lchat/ola/vn/entry/e;)V
    :try_end_7
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_3

    :catch_3
    :goto_4
    if-nez p2, :cond_2

    return-object p3

    :cond_2
    return-object p2
.end method

.method public a(I)Lchat/ola/vn/entry/e;
    .locals 1

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->v:Lchat/ola/vn/r/a/c;

    invoke-virtual {v0, p1}, Lchat/ola/vn/r/a/c;->a(I)Lchat/ola/vn/entry/e;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public getCount()I
    .locals 1

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->v:Lchat/ola/vn/r/a/c;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/c;->j()I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    const/4 v0, 0x0

    return v0
.end method

.method public synthetic getItem(I)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/b/i;->a(I)Lchat/ola/vn/entry/e;

    move-result-object p1

    return-object p1
.end method

.method public getItemViewType(I)I
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/b/i;->a(I)Lchat/ola/vn/entry/e;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/entry/e;->o()B

    move-result p1

    return p1
.end method

.method public getViewTypeCount()I
    .locals 1

    const/4 v0, 0x2

    return v0
.end method

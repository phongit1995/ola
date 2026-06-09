.class public Lchat/ola/vn/pickercontacts/h;
.super Lchat/ola/vn/b/j;

# interfaces
.implements Landroid/widget/CompoundButton$OnCheckedChangeListener;
.implements Landroid/widget/SectionIndexer;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/pickercontacts/h$a;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/b/j<",
        "Lchat/ola/vn/pickercontacts/c;",
        ">;",
        "Landroid/widget/CompoundButton$OnCheckedChangeListener;",
        "Landroid/widget/SectionIndexer;"
    }
.end annotation


# instance fields
.field private a:Ljava/lang/String;

.field private b:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/pickercontacts/c;",
            ">;"
        }
    .end annotation
.end field

.field private c:Landroid/view/View$OnClickListener;

.field private d:Landroid/view/View$OnLongClickListener;

.field private g:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/pickercontacts/c;",
            ">;"
        }
    .end annotation
.end field

.field private h:Lchat/ola/vn/pickercontacts/h$a;

.field private i:Landroid/util/SparseBooleanArray;

.field private j:Z


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    invoke-direct {p0, p1}, Lchat/ola/vn/b/j;-><init>(Landroid/content/Context;)V

    const-string p1, "#ABCDEFGHIJKLMNOPQRSTUVWXYZ"

    iput-object p1, p0, Lchat/ola/vn/pickercontacts/h;->a:Ljava/lang/String;

    const/4 p1, 0x0

    iput-boolean p1, p0, Lchat/ola/vn/pickercontacts/h;->j:Z

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lchat/ola/vn/pickercontacts/h;->b:Ljava/util/List;

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/pickercontacts/h;)Ljava/util/List;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/pickercontacts/h;->b:Ljava/util/List;

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/pickercontacts/h;Ljava/util/List;)Ljava/util/List;
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/pickercontacts/h;->c(Ljava/util/List;)Ljava/util/List;

    move-result-object p0

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/pickercontacts/h;Z)Z
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/pickercontacts/h;->j:Z

    return p1
.end method

.method static synthetic b(Lchat/ola/vn/pickercontacts/h;Ljava/util/List;)Ljava/util/List;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/pickercontacts/h;->g:Ljava/util/List;

    return-object p1
.end method

.method private b(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/pickercontacts/c;",
            ">;)V"
        }
    .end annotation

    :try_start_0
    new-instance v0, Lchat/ola/vn/pickercontacts/h$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/pickercontacts/h$1;-><init>(Lchat/ola/vn/pickercontacts/h;)V

    invoke-static {p1, v0}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method private c(Ljava/util/List;)Ljava/util/List;
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/pickercontacts/c;",
            ">;)",
            "Ljava/util/List<",
            "Lchat/ola/vn/pickercontacts/c;",
            ">;"
        }
    .end annotation

    if-eqz p1, :cond_3

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    invoke-direct {p0, v0}, Lchat/ola/vn/pickercontacts/h;->b(Ljava/util/List;)V

    new-instance v1, Ljava/util/ArrayList;

    const/4 v2, 0x0

    invoke-direct {v1, v2}, Ljava/util/ArrayList;-><init>(I)V

    const/4 v3, 0x0

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p1

    move-object v4, v3

    const/4 v3, 0x0

    :goto_0
    if-ge v3, p1, :cond_2

    new-instance v5, Lchat/ola/vn/pickercontacts/c;

    invoke-direct {v5}, Lchat/ola/vn/pickercontacts/c;-><init>()V

    invoke-interface {v0, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lchat/ola/vn/pickercontacts/c;

    invoke-virtual {v5, v6}, Lchat/ola/vn/pickercontacts/c;->a(Lchat/ola/vn/pickercontacts/c;)V

    if-nez v4, :cond_0

    invoke-virtual {v5}, Lchat/ola/vn/pickercontacts/c;->a()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/String;->charAt(I)C

    move-result v4

    invoke-static {v4}, Ljava/lang/String;->valueOf(C)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/String;->toUpperCase()Ljava/lang/String;

    move-result-object v4

    new-instance v6, Lchat/ola/vn/pickercontacts/c;

    invoke-direct {v6}, Lchat/ola/vn/pickercontacts/c;-><init>()V

    :goto_1
    sget-short v7, Lchat/ola/vn/pickercontacts/c;->a:S

    invoke-virtual {v6, v7}, Lchat/ola/vn/pickercontacts/c;->a(S)V

    invoke-virtual {v6, v4}, Lchat/ola/vn/pickercontacts/c;->a(Ljava/lang/String;)V

    invoke-interface {v1, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_2

    :cond_0
    invoke-virtual {v5}, Lchat/ola/vn/pickercontacts/c;->a()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/String;->charAt(I)C

    move-result v6

    invoke-static {v6}, Ljava/lang/String;->valueOf(C)Ljava/lang/String;

    move-result-object v6

    invoke-static {v4, v6}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v6

    if-nez v6, :cond_1

    invoke-virtual {v5}, Lchat/ola/vn/pickercontacts/c;->a()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/String;->charAt(I)C

    move-result v4

    invoke-static {v4}, Ljava/lang/String;->valueOf(C)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/String;->toUpperCase()Ljava/lang/String;

    move-result-object v4

    new-instance v6, Lchat/ola/vn/pickercontacts/c;

    invoke-direct {v6}, Lchat/ola/vn/pickercontacts/c;-><init>()V

    goto :goto_1

    :cond_1
    :goto_2
    invoke-interface {v1, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_2
    return-object v1

    :cond_3
    return-object p1
.end method


# virtual methods
.method public a()I
    .locals 4

    const/4 v0, 0x0

    const/4 v1, 0x0

    const/4 v2, 0x0

    :goto_0
    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/pickercontacts/h;->getCount()I

    move-result v3

    if-ge v1, v3, :cond_1

    iget-object v3, p0, Lchat/ola/vn/pickercontacts/h;->i:Landroid/util/SparseBooleanArray;

    invoke-virtual {v3, v1, v0}, Landroid/util/SparseBooleanArray;->get(IZ)Z

    move-result v3
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v3, :cond_0

    add-int/lit8 v2, v2, 0x1

    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_1
    return v2

    :catch_0
    return v0
.end method

.method public a(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 7

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/pickercontacts/h;->g:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/pickercontacts/c;

    const v1, 0x7f0b0183

    const v2, 0x7f0b0184

    const/4 v3, 0x0

    if-nez p2, :cond_1

    invoke-virtual {v0}, Lchat/ola/vn/pickercontacts/c;->d()S

    move-result p2

    sget-short v4, Lchat/ola/vn/pickercontacts/c;->b:S

    if-ne p2, v4, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/pickercontacts/h;->b()Landroid/content/Context;

    move-result-object p2

    invoke-static {p2}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p2

    invoke-virtual {p2, v2, p3, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p2

    new-instance p3, Lchat/ola/vn/pickercontacts/e;

    invoke-direct {p3, p2}, Lchat/ola/vn/pickercontacts/e;-><init>(Landroid/view/View;)V

    goto/16 :goto_1

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/pickercontacts/h;->b()Landroid/content/Context;

    move-result-object p2

    invoke-static {p2}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p2

    invoke-virtual {p2, v1, p3, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p2

    new-instance p3, Lchat/ola/vn/pickercontacts/d;

    invoke-direct {p3, p2}, Lchat/ola/vn/pickercontacts/d;-><init>(Landroid/view/View;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    goto :goto_1

    :cond_1
    :try_start_1
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lchat/ola/vn/pickercontacts/e;

    invoke-virtual {v4}, Lchat/ola/vn/pickercontacts/e;->a()S

    move-result v5

    invoke-virtual {v0}, Lchat/ola/vn/pickercontacts/c;->d()S

    move-result v6

    if-eq v5, v6, :cond_3

    invoke-virtual {v0}, Lchat/ola/vn/pickercontacts/c;->d()S

    move-result p2

    sget-short v4, Lchat/ola/vn/pickercontacts/c;->b:S

    if-ne p2, v4, :cond_2

    invoke-virtual {p0}, Lchat/ola/vn/pickercontacts/h;->b()Landroid/content/Context;

    move-result-object p2

    invoke-static {p2}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p2

    invoke-virtual {p2, v2, p3, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p2

    new-instance v4, Lchat/ola/vn/pickercontacts/e;

    invoke-direct {v4, p2}, Lchat/ola/vn/pickercontacts/e;-><init>(Landroid/view/View;)V

    goto :goto_0

    :cond_2
    invoke-virtual {p0}, Lchat/ola/vn/pickercontacts/h;->b()Landroid/content/Context;

    move-result-object p2

    invoke-static {p2}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p2

    invoke-virtual {p2, v1, p3, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p2

    new-instance v4, Lchat/ola/vn/pickercontacts/d;

    invoke-direct {v4, p2}, Lchat/ola/vn/pickercontacts/d;-><init>(Landroid/view/View;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :cond_3
    :goto_0
    move-object p3, v4

    goto :goto_1

    :catch_0
    :try_start_2
    invoke-virtual {v0}, Lchat/ola/vn/pickercontacts/c;->d()S

    move-result p2

    sget-short v4, Lchat/ola/vn/pickercontacts/c;->b:S

    if-ne p2, v4, :cond_4

    invoke-virtual {p0}, Lchat/ola/vn/pickercontacts/h;->b()Landroid/content/Context;

    move-result-object p2

    invoke-static {p2}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p2

    invoke-virtual {p2, v2, p3, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p2

    new-instance p3, Lchat/ola/vn/pickercontacts/e;

    invoke-direct {p3, p2}, Lchat/ola/vn/pickercontacts/e;-><init>(Landroid/view/View;)V

    goto :goto_1

    :cond_4
    invoke-virtual {p0}, Lchat/ola/vn/pickercontacts/h;->b()Landroid/content/Context;

    move-result-object p2

    invoke-static {p2}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p2

    invoke-virtual {p2, v1, p3, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p2

    new-instance p3, Lchat/ola/vn/pickercontacts/d;

    invoke-direct {p3, p2}, Lchat/ola/vn/pickercontacts/d;-><init>(Landroid/view/View;)V

    :goto_1
    iget-object v1, p0, Lchat/ola/vn/pickercontacts/h;->c:Landroid/view/View$OnClickListener;

    invoke-virtual {p3, v1}, Lchat/ola/vn/pickercontacts/e;->a(Landroid/view/View$OnClickListener;)V

    iget-object v1, p0, Lchat/ola/vn/pickercontacts/h;->d:Landroid/view/View$OnLongClickListener;

    invoke-virtual {p3, v1}, Lchat/ola/vn/pickercontacts/e;->a(Landroid/view/View$OnLongClickListener;)V

    invoke-virtual {p3, v0}, Lchat/ola/vn/pickercontacts/e;->a(Lchat/ola/vn/pickercontacts/c;)V

    invoke-virtual {p0, p1}, Lchat/ola/vn/pickercontacts/h;->a(I)Lchat/ola/vn/pickercontacts/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/pickercontacts/c;->d()S

    move-result v0

    sget-short v1, Lchat/ola/vn/pickercontacts/c;->b:S

    if-ne v0, v1, :cond_5

    iget-object v0, p0, Lchat/ola/vn/pickercontacts/h;->i:Landroid/util/SparseBooleanArray;

    invoke-virtual {v0, p1, v3}, Landroid/util/SparseBooleanArray;->get(IZ)Z

    move-result p1

    invoke-virtual {p3, p1}, Lchat/ola/vn/pickercontacts/e;->a(Z)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :cond_5
    return-object p2

    :catch_1
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    const/4 p1, 0x0

    return-object p1
.end method

.method public a(I)Lchat/ola/vn/pickercontacts/c;
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/pickercontacts/h;->g:Ljava/util/List;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/pickercontacts/h;->g:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/pickercontacts/c;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public a(IZ)V
    .locals 2

    :try_start_0
    invoke-virtual {p0, p1}, Lchat/ola/vn/pickercontacts/h;->a(I)Lchat/ola/vn/pickercontacts/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/pickercontacts/c;->d()S

    move-result v0

    sget-short v1, Lchat/ola/vn/pickercontacts/c;->b:S

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lchat/ola/vn/pickercontacts/h;->i:Landroid/util/SparseBooleanArray;

    invoke-virtual {v0, p1, p2}, Landroid/util/SparseBooleanArray;->put(IZ)V

    invoke-virtual {p0}, Lchat/ola/vn/pickercontacts/h;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_0
    return-void
.end method

.method public a(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/pickercontacts/c;",
            ">;)V"
        }
    .end annotation

    :try_start_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lchat/ola/vn/pickercontacts/h;->b:Ljava/util/List;

    iget-object v0, p0, Lchat/ola/vn/pickercontacts/h;->b:Ljava/util/List;

    invoke-direct {p0, v0}, Lchat/ola/vn/pickercontacts/h;->b(Ljava/util/List;)V

    invoke-direct {p0, p1}, Lchat/ola/vn/pickercontacts/h;->c(Ljava/util/List;)Ljava/util/List;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/pickercontacts/h;->g:Ljava/util/List;

    new-instance p1, Landroid/util/SparseBooleanArray;

    iget-object v0, p0, Lchat/ola/vn/pickercontacts/h;->g:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    invoke-direct {p1, v0}, Landroid/util/SparseBooleanArray;-><init>(I)V

    iput-object p1, p0, Lchat/ola/vn/pickercontacts/h;->i:Landroid/util/SparseBooleanArray;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public b(I)Z
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/pickercontacts/h;->i:Landroid/util/SparseBooleanArray;

    const/4 v1, 0x0

    invoke-virtual {v0, p1, v1}, Landroid/util/SparseBooleanArray;->get(IZ)Z

    move-result p1

    return p1
.end method

.method public c()Landroid/util/SparseBooleanArray;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/pickercontacts/h;->i:Landroid/util/SparseBooleanArray;

    return-object v0
.end method

.method public c(I)V
    .locals 1

    invoke-virtual {p0, p1}, Lchat/ola/vn/pickercontacts/h;->b(I)Z

    move-result v0

    xor-int/lit8 v0, v0, 0x1

    invoke-virtual {p0, p1, v0}, Lchat/ola/vn/pickercontacts/h;->a(IZ)V

    return-void
.end method

.method public getCount()I
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/pickercontacts/h;->g:Ljava/util/List;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/pickercontacts/h;->g:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public getFilter()Landroid/widget/Filter;
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/pickercontacts/h;->h:Lchat/ola/vn/pickercontacts/h$a;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/pickercontacts/h$a;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lchat/ola/vn/pickercontacts/h$a;-><init>(Lchat/ola/vn/pickercontacts/h;Lchat/ola/vn/pickercontacts/h$1;)V

    iput-object v0, p0, Lchat/ola/vn/pickercontacts/h;->h:Lchat/ola/vn/pickercontacts/h$a;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/pickercontacts/h;->h:Lchat/ola/vn/pickercontacts/h$a;

    return-object v0
.end method

.method public synthetic getItem(I)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/pickercontacts/h;->a(I)Lchat/ola/vn/pickercontacts/c;

    move-result-object p1

    return-object p1
.end method

.method public getPositionForSection(I)I
    .locals 6

    :goto_0
    const/4 v0, 0x0

    if-ltz p1, :cond_2

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/pickercontacts/h;->g:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    const/4 v2, 0x0

    :goto_1
    if-ge v2, v1, :cond_1

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v4, p0, Lchat/ola/vn/pickercontacts/h;->g:Ljava/util/List;

    invoke-interface {v4, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lchat/ola/vn/pickercontacts/c;

    invoke-virtual {v4}, Lchat/ola/vn/pickercontacts/c;->a()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/String;->charAt(I)C

    move-result v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    const-string v4, ""

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v5, p0, Lchat/ola/vn/pickercontacts/h;->a:Ljava/lang/String;

    invoke-virtual {v5, p1}, Ljava/lang/String;->charAt(I)C

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    const-string v5, ""

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v3, :cond_0

    return v2

    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    :cond_1
    add-int/lit8 p1, p1, -0x1

    goto :goto_0

    :catch_0
    :cond_2
    return v0
.end method

.method public getSectionForPosition(I)I
    .locals 0

    const/4 p1, 0x0

    return p1
.end method

.method public getSections()[Ljava/lang/Object;
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/pickercontacts/h;->a:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    :goto_0
    iget-object v2, p0, Lchat/ola/vn/pickercontacts/h;->a:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    if-ge v1, v2, :cond_0

    iget-object v2, p0, Lchat/ola/vn/pickercontacts/h;->a:Ljava/lang/String;

    invoke-virtual {v2, v1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-static {v2}, Ljava/lang/String;->valueOf(C)Ljava/lang/String;

    move-result-object v2

    aput-object v2, v0, v1

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    return-object v0
.end method

.method public onCheckedChanged(Landroid/widget/CompoundButton;Z)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/pickercontacts/h;->i:Landroid/util/SparseBooleanArray;

    invoke-virtual {p1}, Landroid/widget/CompoundButton;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/Integer;

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    invoke-virtual {v0, p1, p2}, Landroid/util/SparseBooleanArray;->put(IZ)V

    return-void
.end method

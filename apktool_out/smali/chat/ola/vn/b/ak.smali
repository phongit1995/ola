.class public Lchat/ola/vn/b/ak;
.super Lchat/ola/vn/b/j;

# interfaces
.implements Landroid/widget/Filterable;
.implements Landroid/widget/SectionIndexer;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/b/ak$a;,
        Lchat/ola/vn/b/ak$b;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/b/j<",
        "Lchat/ola/vn/message/f;",
        ">;",
        "Landroid/widget/Filterable;",
        "Landroid/widget/SectionIndexer;"
    }
.end annotation


# instance fields
.field private a:Ljava/lang/String;

.field private final b:Ljava/lang/Object;

.field private c:Landroid/view/LayoutInflater;

.field private d:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;"
        }
    .end annotation
.end field

.field private g:Z

.field private h:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private i:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lchat/ola/vn/message/f;",
            ">;"
        }
    .end annotation
.end field

.field private j:Lchat/ola/vn/b/ak$b;

.field private k:Landroid/widget/Filter;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    invoke-direct {p0, p1}, Lchat/ola/vn/b/j;-><init>(Landroid/content/Context;)V

    const-string v0, "#ABCDEFGHIJKLMNOPQRSTUVWXYZ"

    iput-object v0, p0, Lchat/ola/vn/b/ak;->a:Ljava/lang/String;

    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/b/ak;->b:Ljava/lang/Object;

    const-string v0, "layout_inflater"

    invoke-virtual {p1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/view/LayoutInflater;

    iput-object p1, p0, Lchat/ola/vn/b/ak;->c:Landroid/view/LayoutInflater;

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/b/ak;)Lchat/ola/vn/b/ak$b;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/b/ak;->j:Lchat/ola/vn/b/ak$b;

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/b/ak;Ljava/util/ArrayList;)Ljava/util/ArrayList;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/ak;->i:Ljava/util/ArrayList;

    return-object p1
.end method

.method static synthetic a(Lchat/ola/vn/b/ak;Ljava/util/List;)Ljava/util/List;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/ak;->d:Ljava/util/List;

    return-object p1
.end method

.method static synthetic b(Lchat/ola/vn/b/ak;)Ljava/util/List;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/b/ak;->d:Ljava/util/List;

    return-object p0
.end method

.method static synthetic c(Lchat/ola/vn/b/ak;)Ljava/lang/Object;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/b/ak;->b:Ljava/lang/Object;

    return-object p0
.end method

.method static synthetic d(Lchat/ola/vn/b/ak;)Ljava/util/ArrayList;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/b/ak;->i:Ljava/util/ArrayList;

    return-object p0
.end method


# virtual methods
.method public a(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 5

    const/4 v0, 0x0

    if-nez p2, :cond_0

    :try_start_0
    iget-object v1, p0, Lchat/ola/vn/b/ak;->c:Landroid/view/LayoutInflater;

    const v2, 0x7f0b01ae

    invoke-virtual {v1, v2, v0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    new-instance p2, Lchat/ola/vn/entry/b/aj;

    invoke-direct {p2, v1}, Lchat/ola/vn/entry/b/aj;-><init>(Landroid/view/View;)V

    invoke-virtual {v1, p2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    :catch_0
    move-object v1, p2

    goto :goto_1

    :cond_0
    :try_start_2
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/entry/b/aj;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    move-object v4, v1

    move-object v1, p2

    move-object p2, v4

    :goto_0
    :try_start_3
    invoke-virtual {p0, p1}, Lchat/ola/vn/b/ak;->a(I)Lchat/ola/vn/message/f;

    move-result-object v2

    invoke-virtual {p2, v2}, Lchat/ola/vn/entry/b/aj;->a(Lchat/ola/vn/message/f;)V

    iget-object v3, p2, Lchat/ola/vn/entry/b/aj;->a:Landroid/widget/CheckBox;

    invoke-virtual {v3, v0}, Landroid/widget/CheckBox;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    iget-boolean v0, p0, Lchat/ola/vn/b/ak;->g:Z

    if-eqz v0, :cond_1

    iget-object v0, p2, Lchat/ola/vn/entry/b/aj;->a:Landroid/widget/CheckBox;

    const/4 v3, 0x0

    invoke-virtual {v0, v3}, Landroid/widget/CheckBox;->setVisibility(I)V

    iget-object v0, p2, Lchat/ola/vn/entry/b/aj;->a:Landroid/widget/CheckBox;

    invoke-virtual {p0, p1}, Lchat/ola/vn/b/ak;->b(I)Z

    move-result v3

    invoke-virtual {v0, v3}, Landroid/widget/CheckBox;->setChecked(Z)V

    iget-object p2, p2, Lchat/ola/vn/entry/b/aj;->a:Landroid/widget/CheckBox;

    new-instance v0, Lchat/ola/vn/b/ak$1;

    invoke-direct {v0, p0, p1, v2}, Lchat/ola/vn/b/ak$1;-><init>(Lchat/ola/vn/b/ak;ILchat/ola/vn/message/f;)V

    invoke-virtual {p2, v0}, Landroid/widget/CheckBox;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    goto :goto_1

    :cond_1
    iget-object p1, p2, Lchat/ola/vn/entry/b/aj;->a:Landroid/widget/CheckBox;

    const/16 p2, 0x8

    invoke-virtual {p1, p2}, Landroid/widget/CheckBox;->setVisibility(I)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    :catch_1
    :goto_1
    if-nez v1, :cond_2

    return-object p3

    :cond_2
    return-object v1
.end method

.method public a(I)Lchat/ola/vn/message/f;
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/b/ak;->i:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/message/f;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    const/4 p1, 0x0

    return-object p1
.end method

.method public a(IZ)V
    .locals 1

    invoke-virtual {p0, p1}, Lchat/ola/vn/b/ak;->a(I)Lchat/ola/vn/message/f;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/b/ak;->h:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    if-eqz p2, :cond_0

    iget-object p2, p0, Lchat/ola/vn/b/ak;->h:Ljava/util/ArrayList;

    invoke-virtual {p2, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/b/ak;->notifyDataSetChanged()V

    return-void
.end method

.method public a(Lchat/ola/vn/b/ak$b;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/ak;->j:Lchat/ola/vn/b/ak$b;

    return-void
.end method

.method public b(I)Z
    .locals 1

    invoke-virtual {p0, p1}, Lchat/ola/vn/b/ak;->a(I)Lchat/ola/vn/message/f;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/b/ak;->h:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->contains(Ljava/lang/Object;)Z

    move-result p1

    return p1
.end method

.method public getCount()I
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/b/ak;->i:Ljava/util/ArrayList;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return v1

    :cond_0
    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/b/ak;->i:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return v1
.end method

.method public getFilter()Landroid/widget/Filter;
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/b/ak;->k:Landroid/widget/Filter;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/b/ak$a;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lchat/ola/vn/b/ak$a;-><init>(Lchat/ola/vn/b/ak;Lchat/ola/vn/b/ak$1;)V

    iput-object v0, p0, Lchat/ola/vn/b/ak;->k:Landroid/widget/Filter;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/b/ak;->k:Landroid/widget/Filter;

    return-object v0
.end method

.method public synthetic getItem(I)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/b/ak;->a(I)Lchat/ola/vn/message/f;

    move-result-object p1

    return-object p1
.end method

.method public getPositionForSection(I)I
    .locals 5

    :goto_0
    const/4 v0, 0x0

    if-ltz p1, :cond_4

    const/4 v1, 0x0

    :goto_1
    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/b/ak;->getCount()I

    move-result v2

    if-ge v1, v2, :cond_3

    if-nez p1, :cond_1

    const/4 v2, 0x0

    :goto_2
    const/16 v3, 0x9

    if-gt v2, v3, :cond_2

    invoke-virtual {p0, v1}, Lchat/ola/vn/b/ak;->a(I)Lchat/ola/vn/message/f;

    move-result-object v3

    invoke-virtual {v3}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/String;->charAt(I)C

    move-result v3

    invoke-static {v3}, Ljava/lang/String;->valueOf(C)Ljava/lang/String;

    move-result-object v3

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/mg/ola/common/d/h;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    return v1

    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    :cond_1
    invoke-virtual {p0, v1}, Lchat/ola/vn/b/ak;->a(I)Lchat/ola/vn/message/f;

    move-result-object v2

    invoke-virtual {v2}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-static {v2}, Ljava/lang/String;->valueOf(C)Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lchat/ola/vn/b/ak;->a:Ljava/lang/String;

    invoke-virtual {v3, p1}, Ljava/lang/String;->charAt(I)C

    move-result v3

    invoke-static {v3}, Ljava/lang/String;->valueOf(C)Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/mg/ola/common/d/h;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v2, :cond_2

    return v1

    :cond_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    :cond_3
    add-int/lit8 p1, p1, -0x1

    goto :goto_0

    :catch_0
    :cond_4
    return v0
.end method

.method public getSectionForPosition(I)I
    .locals 0

    const/4 p1, 0x0

    return p1
.end method

.method public getSections()[Ljava/lang/Object;
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/b/ak;->a:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    :goto_0
    iget-object v2, p0, Lchat/ola/vn/b/ak;->a:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    if-ge v1, v2, :cond_0

    iget-object v2, p0, Lchat/ola/vn/b/ak;->a:Ljava/lang/String;

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

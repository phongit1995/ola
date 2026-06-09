.class public Lchat/ola/vn/b/al;
.super Lchat/ola/vn/b/j;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/b/al$a;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/b/j<",
        "Ljava/lang/String;",
        ">;"
    }
.end annotation


# instance fields
.field private a:Landroid/view/LayoutInflater;

.field private b:Landroid/view/View$OnLongClickListener;

.field private c:[Ljava/lang/String;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/b/j;-><init>(Landroid/content/Context;)V

    invoke-static {p1}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/b/al;->a:Landroid/view/LayoutInflater;

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/b/al;)Landroid/view/View$OnLongClickListener;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/b/al;->b:Landroid/view/View$OnLongClickListener;

    return-object p0
.end method

.method static synthetic b(Lchat/ola/vn/b/al;)[Ljava/lang/String;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/b/al;->c:[Ljava/lang/String;

    return-object p0
.end method


# virtual methods
.method public a(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 4

    if-nez p2, :cond_0

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/b/al;->a:Landroid/view/LayoutInflater;

    const v1, 0x7f0b01ba

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    new-instance p2, Lchat/ola/vn/b/al$a;

    invoke-direct {p2, p0, v0}, Lchat/ola/vn/b/al$a;-><init>(Lchat/ola/vn/b/al;Landroid/view/View;)V

    invoke-virtual {v0, p2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    :catch_0
    move-object v0, p2

    goto :goto_1

    :cond_0
    :try_start_2
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/b/al$a;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    move-object v3, v0

    move-object v0, p2

    move-object p2, v3

    :goto_0
    :try_start_3
    invoke-virtual {p0, p1}, Lchat/ola/vn/b/al;->a(I)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Lchat/ola/vn/b/al$a;->a(Ljava/lang/String;)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    :catch_1
    :goto_1
    if-nez v0, :cond_1

    return-object p3

    :cond_1
    return-object v0
.end method

.method public a(I)Ljava/lang/String;
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/b/al;->c:[Ljava/lang/String;

    aget-object p1, v0, p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public a([Ljava/lang/String;)V
    .locals 0

    if-nez p1, :cond_0

    return-void

    :cond_0
    iput-object p1, p0, Lchat/ola/vn/b/al;->c:[Ljava/lang/String;

    invoke-virtual {p0}, Lchat/ola/vn/b/al;->notifyDataSetChanged()V

    return-void
.end method

.method public getCount()I
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/b/al;->c:[Ljava/lang/String;

    array-length v0, v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    const/4 v0, 0x0

    return v0
.end method

.method public synthetic getItem(I)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/b/al;->a(I)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

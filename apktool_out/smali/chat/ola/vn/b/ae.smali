.class public Lchat/ola/vn/b/ae;
.super Lchat/ola/vn/b/j;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/b/ae$a;
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
.field public a:I

.field private b:Landroid/view/LayoutInflater;

.field private c:Landroid/view/View$OnClickListener;

.field private d:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Landroid/content/Context;Ljava/util/ArrayList;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/ArrayList<",
            "Ljava/lang/String;",
            ">;I)V"
        }
    .end annotation

    invoke-direct {p0, p1}, Lchat/ola/vn/b/j;-><init>(Landroid/content/Context;)V

    invoke-static {p1}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/b/ae;->b:Landroid/view/LayoutInflater;

    iput p3, p0, Lchat/ola/vn/b/ae;->a:I

    iput-object p2, p0, Lchat/ola/vn/b/ae;->d:Ljava/util/ArrayList;

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/b/ae;)Landroid/view/View$OnClickListener;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/b/ae;->c:Landroid/view/View$OnClickListener;

    return-object p0
.end method


# virtual methods
.method public a(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 4

    if-nez p2, :cond_0

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/b/ae;->b:Landroid/view/LayoutInflater;

    const v1, 0x7f0b01bf

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    new-instance p2, Lchat/ola/vn/b/ae$a;

    invoke-direct {p2, p0, v0}, Lchat/ola/vn/b/ae$a;-><init>(Lchat/ola/vn/b/ae;Landroid/view/View;)V

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

    check-cast v0, Lchat/ola/vn/b/ae$a;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    move-object v3, v0

    move-object v0, p2

    move-object p2, v3

    :goto_0
    :try_start_3
    invoke-virtual {p0, p1}, Lchat/ola/vn/b/ae;->a(I)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Lchat/ola/vn/b/ae$a;->a(Ljava/lang/String;)V
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
    iget-object v0, p0, Lchat/ola/vn/b/ae;->d:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public a(Landroid/view/View$OnClickListener;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/ae;->c:Landroid/view/View$OnClickListener;

    return-void
.end method

.method public a(Ljava/util/ArrayList;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lchat/ola/vn/b/ae;->d:Ljava/util/ArrayList;

    return-void
.end method

.method public getCount()I
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/b/ae;->d:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

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

    invoke-virtual {p0, p1}, Lchat/ola/vn/b/ae;->a(I)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

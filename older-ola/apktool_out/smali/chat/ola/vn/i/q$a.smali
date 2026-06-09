.class Lchat/ola/vn/i/q$a;
.super Lchat/ola/vn/b/aa;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/i/q;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/i/q$a$a;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/b/aa<",
        "Lchat/ola/vn/entity/e;",
        ">;"
    }
.end annotation


# instance fields
.field private a:Landroid/view/LayoutInflater;

.field final synthetic b:Lchat/ola/vn/i/q;


# direct methods
.method public constructor <init>(Lchat/ola/vn/i/q;Landroid/content/Context;Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/e;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lchat/ola/vn/i/q$a;->b:Lchat/ola/vn/i/q;

    invoke-direct {p0, p2, p3}, Lchat/ola/vn/b/aa;-><init>(Landroid/content/Context;Ljava/util/List;)V

    invoke-static {p2}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/i/q$a;->a:Landroid/view/LayoutInflater;

    return-void
.end method


# virtual methods
.method public a(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 4

    if-nez p2, :cond_0

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/i/q$a;->a:Landroid/view/LayoutInflater;

    const v1, 0x7f0b00bf

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    new-instance p2, Lchat/ola/vn/i/q$a$a;

    invoke-direct {p2, p0, v0}, Lchat/ola/vn/i/q$a$a;-><init>(Lchat/ola/vn/i/q$a;Landroid/view/View;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    :catch_0
    move-object v0, p2

    goto :goto_2

    :cond_0
    :try_start_2
    invoke-virtual {p2}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/i/q$a$a;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    move-object v3, v0

    move-object v0, p2

    move-object p2, v3

    :goto_0
    :try_start_3
    invoke-virtual {p0, p1}, Lchat/ola/vn/i/q$a;->getItem(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/entity/e;

    iget-object v2, p2, Lchat/ola/vn/i/q$a$a;->b:Landroid/widget/TextView;

    invoke-virtual {p0, v1}, Lchat/ola/vn/i/q$a;->a(Lchat/ola/vn/entity/e;)Ljava/lang/CharSequence;

    move-result-object v1

    invoke-virtual {v2, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v1, p0, Lchat/ola/vn/i/q$a;->b:Lchat/ola/vn/i/q;

    invoke-static {v1}, Lchat/ola/vn/i/q;->a(Lchat/ola/vn/i/q;)I

    move-result v1

    if-ltz v1, :cond_2

    iget-object v1, p0, Lchat/ola/vn/i/q$a;->b:Lchat/ola/vn/i/q;

    invoke-static {v1}, Lchat/ola/vn/i/q;->a(Lchat/ola/vn/i/q;)I

    move-result v1

    if-ne v1, p1, :cond_1

    iget-object p1, p2, Lchat/ola/vn/i/q$a$a;->a:Landroid/widget/ImageView;

    const v1, 0x7f080786

    invoke-virtual {p1, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object p1, p2, Lchat/ola/vn/i/q$a$a;->a:Landroid/widget/ImageView;

    const/4 p2, 0x0

    :goto_1
    invoke-virtual {p1, p2}, Landroid/widget/ImageView;->setVisibility(I)V

    goto :goto_2

    :cond_1
    iget-object p1, p2, Lchat/ola/vn/i/q$a$a;->a:Landroid/widget/ImageView;

    const/4 p2, 0x4

    goto :goto_1

    :cond_2
    iget-object p1, p2, Lchat/ola/vn/i/q$a$a;->a:Landroid/widget/ImageView;
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    const/16 p2, 0x8

    goto :goto_1

    :catch_1
    :goto_2
    if-nez v0, :cond_3

    return-object p3

    :cond_3
    return-object v0
.end method

.method public a(Lchat/ola/vn/entity/e;)Ljava/lang/CharSequence;
    .locals 0

    if-nez p1, :cond_0

    const/4 p1, 0x0

    return-object p1

    :cond_0
    invoke-virtual {p1}, Lchat/ola/vn/entity/e;->z()Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method public bridge synthetic a(Ljava/lang/Object;)Ljava/lang/CharSequence;
    .locals 0

    check-cast p1, Lchat/ola/vn/entity/e;

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/q$a;->a(Lchat/ola/vn/entity/e;)Ljava/lang/CharSequence;

    move-result-object p1

    return-object p1
.end method

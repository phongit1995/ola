.class Lchat/ola/vn/view/i$b;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/view/i;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "b"
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/view/i;

.field private b:Landroid/view/View;

.field private c:Lchat/ola/vn/view/OlaCachedImageView;


# direct methods
.method public constructor <init>(Lchat/ola/vn/view/i;Landroid/view/View;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/i$b;->a:Lchat/ola/vn/view/i;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const p1, 0x7f090499

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object p1, p0, Lchat/ola/vn/view/i$b;->c:Lchat/ola/vn/view/OlaCachedImageView;

    const p1, 0x7f09049a

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/view/i$b;->b:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/view/i$b;->c:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p1, p0}, Lchat/ola/vn/view/OlaCachedImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/entity/v;)V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/view/i$b;->c:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, p1}, Lchat/ola/vn/view/OlaCachedImageView;->setTag(Ljava/lang/Object;)V

    invoke-virtual {p1}, Lchat/ola/vn/entity/v;->a()Ljava/lang/String;

    move-result-object v0

    invoke-static {}, Lchat/ola/vn/view/i;->c()Lchat/ola/vn/entity/v;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/entity/v;->a()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/view/i$b;->b:Landroid/view/View;

    sget v1, Lchat/ola/vn/f;->M:I

    :goto_0
    invoke-virtual {v0, v1}, Landroid/view/View;->setBackgroundColor(I)V

    goto :goto_1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/view/i$b;->b:Landroid/view/View;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v1, 0x0

    goto :goto_0

    :catch_0
    :goto_1
    invoke-virtual {p1}, Lchat/ola/vn/entity/v;->a()Ljava/lang/String;

    move-result-object v0

    const-string v1, "recent"

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-static {}, Lchat/ola/vn/view/i;->c()Lchat/ola/vn/entity/v;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-static {}, Lchat/ola/vn/view/i;->c()Lchat/ola/vn/entity/v;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/entity/v;->a()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1}, Lchat/ola/vn/entity/v;->a()Ljava/lang/String;

    move-result-object p1

    invoke-static {v0, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/view/i$b;->c:Lchat/ola/vn/view/OlaCachedImageView;

    const v0, 0x7f08076d

    goto :goto_2

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/view/i$b;->c:Lchat/ola/vn/view/OlaCachedImageView;

    const v0, 0x7f08076c

    :goto_2
    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setImageResource(I)V

    return-void

    :cond_2
    invoke-virtual {p1}, Lchat/ola/vn/entity/v;->b()Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_3

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/view/i$b;->c:Lchat/ola/vn/view/OlaCachedImageView;

    const/16 v2, 0x78

    invoke-virtual {v0, p1, v1, v2}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;I)V

    :cond_3
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 2

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    const v1, 0x7f090499

    if-eq v0, v1, :cond_0

    return-void

    :cond_0
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/v;

    invoke-virtual {p1}, Lchat/ola/vn/entity/v;->a()Ljava/lang/String;

    move-result-object v0

    invoke-static {}, Lchat/ola/vn/view/i;->c()Lchat/ola/vn/entity/v;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/entity/v;->a()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-static {p1}, Lchat/ola/vn/view/i;->a(Lchat/ola/vn/entity/v;)Lchat/ola/vn/entity/v;

    iget-object v0, p0, Lchat/ola/vn/view/i$b;->a:Lchat/ola/vn/view/i;

    invoke-static {v0}, Lchat/ola/vn/view/i;->a(Lchat/ola/vn/view/i;)Lchat/ola/vn/view/i$a;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/view/i$a;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    const/4 v0, 0x0

    :try_start_1
    invoke-static {}, Lchat/ola/vn/view/i;->b()Ljava/util/List;

    move-result-object v1

    invoke-interface {v1, p1}, Ljava/util/List;->indexOf(Ljava/lang/Object;)I

    move-result p1
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :catch_0
    const/4 p1, 0x0

    :goto_0
    :try_start_2
    iget-object v0, p0, Lchat/ola/vn/view/i$b;->a:Lchat/ola/vn/view/i;

    invoke-static {v0}, Lchat/ola/vn/view/i;->c(Lchat/ola/vn/view/i;)Landroid/support/v4/view/ViewPager;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, p1, v1}, Landroid/support/v4/view/ViewPager;->setCurrentItem(IZ)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_1
    return-void
.end method

.class Lchat/ola/vn/b/a$a;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/b/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field protected a:Lchat/ola/vn/view/OlaCachedImageView;

.field protected b:Landroid/widget/TextView;

.field protected c:Landroid/widget/TextView;

.field protected d:Landroid/view/View;

.field final synthetic e:Lchat/ola/vn/b/a;


# direct methods
.method protected constructor <init>(Lchat/ola/vn/b/a;Landroid/view/View;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/a$a;->e:Lchat/ola/vn/b/a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const p1, 0x7f090062

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object p1, p0, Lchat/ola/vn/b/a$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    const p1, 0x7f090061

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/b/a$a;->b:Landroid/widget/TextView;

    const p1, 0x7f090059

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/b/a$a;->c:Landroid/widget/TextView;

    const p1, 0x7f090162

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/b/a$a;->d:Landroid/view/View;

    return-void
.end method


# virtual methods
.method protected a(Lchat/ola/vn/entity/l;)V
    .locals 5

    :try_start_0
    iget-object v0, p1, Lchat/ola/vn/entity/l;->c:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_1

    iget-object v0, p1, Lchat/ola/vn/entity/l;->c:Ljava/lang/String;

    sget-object v2, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v0, v2}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    const-string v2, "http"

    invoke-virtual {v0, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v2, p1, Lchat/ola/vn/entity/l;->c:Ljava/lang/String;

    iget-object v3, p0, Lchat/ola/vn/b/a$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v2, v3, v1, v1}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;IZ)V

    goto :goto_0

    :cond_0
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v2, p1, Lchat/ola/vn/entity/l;->c:Ljava/lang/String;

    iget-object v3, p0, Lchat/ola/vn/b/a$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    sget v4, Lchat/ola/vn/e;->c:I

    div-int/lit8 v4, v4, 0x5

    invoke-virtual {v0, v2, v3, v1, v4}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;II)V

    goto :goto_0

    :cond_1
    iget-object v0, p1, Lchat/ola/vn/entity/l;->d:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v2, p1, Lchat/ola/vn/entity/l;->d:Ljava/lang/String;

    iget-object v3, p0, Lchat/ola/vn/b/a$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v2, v3}, Lchat/ola/vn/c/t;->e(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V

    goto :goto_0

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/b/a$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v2, 0x0

    invoke-virtual {v0, v2, v2}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    :goto_0
    iget-boolean v0, p1, Lchat/ola/vn/entity/l;->k:Z

    if-eqz v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/b/a$a;->d:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    goto :goto_1

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/b/a$a;->d:Landroid/view/View;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :goto_1
    iget-object v0, p0, Lchat/ola/vn/b/a$a;->b:Landroid/widget/TextView;

    iget-object v1, p1, Lchat/ola/vn/entity/l;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/b/a$a;->c:Landroid/widget/TextView;

    iget p1, p1, Lchat/ola/vn/entity/l;->g:I

    int-to-long v1, p1

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

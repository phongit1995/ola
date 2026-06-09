.class Lchat/ola/vn/b/p$b;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/b/p;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "b"
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/b/p;

.field private b:Lchat/ola/vn/entity/OlaVenueEntity;

.field private c:Lchat/ola/vn/view/OlaCachedImageView;

.field private d:Landroid/view/View;

.field private e:Landroid/view/View;

.field private f:Landroid/widget/TextView;

.field private g:Landroid/widget/TextView;

.field private h:Landroid/widget/TextView;

.field private i:Landroid/widget/TextView;

.field private j:Landroid/view/View;

.field private k:Landroid/view/View;

.field private l:Landroid/view/View;

.field private m:Landroid/view/View$OnClickListener;

.field private n:Landroid/view/View$OnLongClickListener;


# direct methods
.method public constructor <init>(Lchat/ola/vn/b/p;Landroid/view/View;)V
    .locals 1

    iput-object p1, p0, Lchat/ola/vn/b/p$b;->a:Lchat/ola/vn/b/p;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const p1, 0x7f0905ca

    :try_start_0
    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/b/p$b;->e:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/b/p$b;->e:Landroid/view/View;

    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Landroid/view/View;->setClickable(Z)V

    const p1, 0x7f0905cb

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/b/p$b;->d:Landroid/view/View;

    const p1, 0x7f090269

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object p1, p0, Lchat/ola/vn/b/p$b;->c:Lchat/ola/vn/view/OlaCachedImageView;

    const p1, 0x7f09057c

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/b/p$b;->f:Landroid/widget/TextView;

    const p1, 0x7f09057b

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/b/p$b;->g:Landroid/widget/TextView;

    const p1, 0x7f0904f3

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/b/p$b;->h:Landroid/widget/TextView;

    const p1, 0x7f09057a

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/b/p$b;->i:Landroid/widget/TextView;

    const p1, 0x7f0900c6

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/b/p$b;->k:Landroid/view/View;

    const p1, 0x7f090514

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/b/p$b;->l:Landroid/view/View;

    iput-object p2, p0, Lchat/ola/vn/b/p$b;->j:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/b/p$b;->j:Landroid/view/View;

    invoke-virtual {p1, p0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private a()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/b/p$b;->k:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/b/p$b;->m:Landroid/view/View$OnClickListener;

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/b/p$b;->k:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/b/p$b;->b:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {v0, v1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/b/p$b;->e:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/b/p$b;->m:Landroid/view/View$OnClickListener;

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/b/p$b;->e:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/b/p$b;->b:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {v0, v1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    return-void
.end method


# virtual methods
.method public a(Landroid/view/View$OnClickListener;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/p$b;->m:Landroid/view/View$OnClickListener;

    return-void
.end method

.method public a(Landroid/view/View$OnLongClickListener;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/p$b;->n:Landroid/view/View$OnLongClickListener;

    return-void
.end method

.method public a(Lchat/ola/vn/entity/OlaVenueEntity;)V
    .locals 4

    :try_start_0
    iput-object p1, p0, Lchat/ola/vn/b/p$b;->b:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/b/p$b;->c:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v1, p0, Lchat/ola/vn/b/p$b;->b:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {v1}, Lchat/ola/vn/entity/OlaVenueEntity;->f()Ljava/lang/String;

    move-result-object v1

    const v2, 0x7f080697

    const/4 v3, 0x0

    invoke-static {p1, v0, v1, v2, v3}, Lchat/ola/vn/c/f;->a(Landroid/content/Context;Lchat/ola/vn/view/OlaCachedImageView;Ljava/lang/String;IZ)V

    iget-object p1, p0, Lchat/ola/vn/b/p$b;->f:Landroid/widget/TextView;

    iget-object v0, p0, Lchat/ola/vn/b/p$b;->b:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {v0}, Lchat/ola/vn/entity/OlaVenueEntity;->c()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/b/p$b;->g:Landroid/widget/TextView;

    iget-object v0, p0, Lchat/ola/vn/b/p$b;->b:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {v0}, Lchat/ola/vn/entity/OlaVenueEntity;->h()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/b/p$b;->b:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {p1}, Lchat/ola/vn/entity/OlaVenueEntity;->h()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/b/p$b;->l:Landroid/view/View;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/b/p$b;->l:Landroid/view/View;

    invoke-virtual {p1, v3}, Landroid/view/View;->setVisibility(I)V

    :goto_0
    iget-object p1, p0, Lchat/ola/vn/b/p$b;->b:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {p1}, Lchat/ola/vn/entity/OlaVenueEntity;->i()I

    move-result p1

    if-lez p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/b/p$b;->h:Landroid/widget/TextView;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "("

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lchat/ola/vn/b/p$b;->b:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {v1}, Lchat/ola/vn/entity/OlaVenueEntity;->i()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/c;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const v2, 0x7f0f0473

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, ")"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :goto_1
    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_2

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/b/p$b;->h:Landroid/widget/TextView;

    const-string v0, ""

    goto :goto_1

    :goto_2
    iget-object p1, p0, Lchat/ola/vn/b/p$b;->i:Landroid/widget/TextView;

    iget-object v0, p0, Lchat/ola/vn/b/p$b;->b:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {v0}, Lchat/ola/vn/entity/OlaVenueEntity;->e()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    invoke-direct {p0}, Lchat/ola/vn/b/p$b;->a()V

    return-void
.end method

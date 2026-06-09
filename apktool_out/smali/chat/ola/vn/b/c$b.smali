.class Lchat/ola/vn/b/c$b;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/b/c;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "b"
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/b/c;

.field private b:Landroid/widget/TextView;

.field private c:Lchat/ola/vn/view/OlaCachedImageView;

.field private d:Lchat/ola/vn/entity/OlaCheckInActionEntity;


# direct methods
.method public constructor <init>(Lchat/ola/vn/b/c;Landroid/view/View;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/c$b;->a:Lchat/ola/vn/b/c;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const p1, 0x7f090504

    :try_start_0
    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/b/c$b;->b:Landroid/widget/TextView;

    const p1, 0x7f090267

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object p1, p0, Lchat/ola/vn/b/c$b;->c:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p2, p0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/entity/OlaCheckInActionEntity;)V
    .locals 4

    :try_start_0
    iput-object p1, p0, Lchat/ola/vn/b/c$b;->d:Lchat/ola/vn/entity/OlaCheckInActionEntity;

    iget-object v0, p0, Lchat/ola/vn/b/c$b;->b:Landroid/widget/TextView;

    invoke-virtual {p1}, Lchat/ola/vn/entity/OlaCheckInActionEntity;->b()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/b/c$b;->c:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v1, p0, Lchat/ola/vn/b/c$b;->d:Lchat/ola/vn/entity/OlaCheckInActionEntity;

    invoke-virtual {v1}, Lchat/ola/vn/entity/OlaCheckInActionEntity;->c()Ljava/lang/String;

    move-result-object v1

    const v2, 0x7f080698

    const/4 v3, 0x0

    invoke-static {p1, v0, v1, v2, v3}, Lchat/ola/vn/c/f;->a(Landroid/content/Context;Lchat/ola/vn/view/OlaCachedImageView;Ljava/lang/String;IZ)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

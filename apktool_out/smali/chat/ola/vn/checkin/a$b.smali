.class Lchat/ola/vn/checkin/a$b;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/checkin/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "b"
.end annotation


# instance fields
.field public a:Lchat/ola/vn/entity/OlaCheckInItemEntity;

.field final synthetic b:Lchat/ola/vn/checkin/a;

.field private c:Lchat/ola/vn/view/OlaCachedImageView;

.field private d:Landroid/widget/TextView;

.field private e:Landroid/view/View;


# direct methods
.method public constructor <init>(Lchat/ola/vn/checkin/a;Landroid/view/View;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/checkin/a$b;->b:Lchat/ola/vn/checkin/a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    :try_start_0
    iput-object p2, p0, Lchat/ola/vn/checkin/a$b;->e:Landroid/view/View;

    const p1, 0x7f09026a

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object p1, p0, Lchat/ola/vn/checkin/a$b;->c:Lchat/ola/vn/view/OlaCachedImageView;

    const p1, 0x7f090528

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/checkin/a$b;->d:Landroid/widget/TextView;

    iget-object p1, p0, Lchat/ola/vn/checkin/a$b;->e:Landroid/view/View;

    invoke-virtual {p1, p0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/entity/OlaCheckInItemEntity;)V
    .locals 4

    :try_start_0
    new-instance v0, Lchat/ola/vn/entity/OlaCheckInItemEntity;

    invoke-direct {v0}, Lchat/ola/vn/entity/OlaCheckInItemEntity;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/checkin/a$b;->a:Lchat/ola/vn/entity/OlaCheckInItemEntity;

    iget-object v0, p0, Lchat/ola/vn/checkin/a$b;->a:Lchat/ola/vn/entity/OlaCheckInItemEntity;

    invoke-virtual {v0, p1}, Lchat/ola/vn/entity/OlaCheckInItemEntity;->a(Lchat/ola/vn/entity/OlaCheckInItemEntity;)V

    iget-object p1, p0, Lchat/ola/vn/checkin/a$b;->d:Landroid/widget/TextView;

    iget-object v0, p0, Lchat/ola/vn/checkin/a$b;->a:Lchat/ola/vn/entity/OlaCheckInItemEntity;

    invoke-virtual {v0}, Lchat/ola/vn/entity/OlaCheckInItemEntity;->b()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/checkin/a$b;->c:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v1, p0, Lchat/ola/vn/checkin/a$b;->a:Lchat/ola/vn/entity/OlaCheckInItemEntity;

    invoke-virtual {v1}, Lchat/ola/vn/entity/OlaCheckInItemEntity;->d()Ljava/lang/String;

    move-result-object v1

    const v2, 0x7f080698

    const/4 v3, 0x0

    invoke-static {p1, v0, v1, v2, v3}, Lchat/ola/vn/c/f;->a(Landroid/content/Context;Lchat/ola/vn/view/OlaCachedImageView;Ljava/lang/String;IZ)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

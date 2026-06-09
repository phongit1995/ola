.class public Lchat/ola/vn/tradingvip/d;
.super Lchat/ola/vn/tradingvip/a;

# interfaces
.implements Landroid/view/View$OnClickListener;


# static fields
.field public static a:J

.field public static b:I

.field public static c:Lchat/ola/vn/entity/ag;


# instance fields
.field private d:Landroid/widget/TextView;

.field private e:Landroid/widget/TextView;

.field private f:Landroid/widget/TextView;

.field private g:Landroid/widget/TextView;

.field private h:Landroid/widget/TextView;

.field private i:Lchat/ola/vn/view/OlaCachedImageView;

.field private j:Landroid/widget/ImageView;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/tradingvip/a;-><init>()V

    return-void
.end method

.method private v()V
    .locals 5

    sget-object v0, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->e:Lchat/ola/vn/entity/ah;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/tradingvip/d;->j:Landroid/widget/ImageView;

    invoke-static {}, Lchat/ola/vn/j;->a()Lchat/ola/vn/j;

    move-result-object v1

    sget-object v2, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->e:Lchat/ola/vn/entity/ah;

    invoke-virtual {v2}, Lchat/ola/vn/entity/ah;->b()I

    move-result v2

    invoke-virtual {v1, v2}, Lchat/ola/vn/j;->a(I)Landroid/graphics/Bitmap;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageBitmap(Landroid/graphics/Bitmap;)V

    iget-object v0, p0, Lchat/ola/vn/tradingvip/d;->h:Landroid/widget/TextView;

    sget-object v1, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->e:Lchat/ola/vn/entity/ah;

    invoke-virtual {v1}, Lchat/ola/vn/entity/ah;->d()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/tradingvip/d;->f:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    sget-wide v2, Lchat/ola/vn/tradingvip/d;->a:J

    invoke-static {v2, v3}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, " KEN"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    sget v0, Lchat/ola/vn/tradingvip/d;->b:I

    const/4 v1, 0x1

    if-le v0, v1, :cond_1

    iget-object v0, p0, Lchat/ola/vn/tradingvip/d;->g:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    sget v2, Lchat/ola/vn/tradingvip/d;->b:I

    int-to-long v2, v2

    invoke-static {v2, v3}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, " "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v2, 0x7f0f04a4

    :goto_0
    invoke-virtual {p0, v2}, Lchat/ola/vn/tradingvip/d;->getString(I)Ljava/lang/String;

    move-result-object v2

    sget-object v3, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v2, v3}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_1

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/tradingvip/d;->g:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    sget v2, Lchat/ola/vn/tradingvip/d;->b:I

    int-to-long v2, v2

    invoke-static {v2, v3}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, " "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v2, 0x7f0f04a3

    goto :goto_0

    :goto_1
    iget-object v0, p0, Lchat/ola/vn/tradingvip/d;->d:Landroid/widget/TextView;

    sget-object v1, Lchat/ola/vn/tradingvip/d;->c:Lchat/ola/vn/entity/ag;

    iget-object v1, v1, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    const/4 v0, 0x0

    :try_start_0
    sget-object v1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    sget-object v2, Lchat/ola/vn/tradingvip/d;->c:Lchat/ola/vn/entity/ag;

    iget-object v2, v2, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    invoke-virtual {v1, v2}, Lchat/ola/vn/message/g;->d(Ljava/lang/String;)Lchat/ola/vn/message/f;

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    move-object v0, v1

    :catch_0
    const/16 v1, 0x8

    const/4 v2, 0x0

    if-eqz v0, :cond_3

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_2

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v4}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_2

    iget-object v1, p0, Lchat/ola/vn/tradingvip/d;->e:Landroid/widget/TextView;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_3

    :cond_2
    sget-object v0, Lchat/ola/vn/tradingvip/d;->c:Lchat/ola/vn/entity/ag;

    iget-object v0, v0, Lchat/ola/vn/entity/ag;->k:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_4

    goto :goto_2

    :cond_3
    sget-object v0, Lchat/ola/vn/tradingvip/d;->c:Lchat/ola/vn/entity/ag;

    iget-object v0, v0, Lchat/ola/vn/entity/ag;->k:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_4

    :goto_2
    iget-object v0, p0, Lchat/ola/vn/tradingvip/d;->e:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_4

    :cond_4
    iget-object v0, p0, Lchat/ola/vn/tradingvip/d;->e:Landroid/widget/TextView;

    sget-object v1, Lchat/ola/vn/tradingvip/d;->c:Lchat/ola/vn/entity/ag;

    iget-object v1, v1, Lchat/ola/vn/entity/ag;->k:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :goto_3
    iget-object v0, p0, Lchat/ola/vn/tradingvip/d;->e:Landroid/widget/TextView;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    :goto_4
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/tradingvip/d;->c:Lchat/ola/vn/entity/ag;

    iget-object v1, v1, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    iget-object v2, p0, Lchat/ola/vn/tradingvip/d;->i:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/c/t;->g(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V

    return-void
.end method

.method private x()V
    .locals 7

    :try_start_0
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    sget-object v1, Lchat/ola/vn/tradingvip/d;->c:Lchat/ola/vn/entity/ag;

    iget-object v1, v1, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    sget-object v2, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->e:Lchat/ola/vn/entity/ah;

    invoke-virtual {v2}, Lchat/ola/vn/entity/ah;->e()Ljava/lang/String;

    move-result-object v2

    sget v3, Lchat/ola/vn/tradingvip/d;->b:I

    sget-wide v4, Lchat/ola/vn/tradingvip/d;->a:J

    new-instance v6, Lchat/ola/vn/tradingvip/d$1;

    invoke-direct {v6, p0}, Lchat/ola/vn/tradingvip/d$1;-><init>(Lchat/ola/vn/tradingvip/d;)V

    invoke-static {v6}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v6

    invoke-virtual/range {v0 .. v6}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;IJS)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    sget-object v1, Lchat/ola/vn/tradingvip/d;->c:Lchat/ola/vn/entity/ag;

    iget-object v1, v1, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/message/g;->d(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object v0

    const/4 v1, 0x1

    if-nez v0, :cond_0

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    sget-object v3, Lchat/ola/vn/tradingvip/d;->c:Lchat/ola/vn/entity/ag;

    iget-object v3, v3, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    invoke-virtual {v0, v3, v2, v1}, Lchat/ola/vn/message/g;->b(Ljava/lang/String;SZ)Lchat/ola/vn/message/f;

    move-result-object v0

    :cond_0
    if-eqz v0, :cond_1

    sget-object v2, Lchat/ola/vn/tradingvip/d;->c:Lchat/ola/vn/entity/ag;

    iget-object v2, v2, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    sget-wide v3, Lchat/ola/vn/tradingvip/d;->a:J

    sget v5, Lchat/ola/vn/tradingvip/d;->b:I

    sget-object v6, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->e:Lchat/ola/vn/entity/ah;

    invoke-static {v2, v3, v4, v5, v6}, Lchat/ola/vn/message/e;->a(Ljava/lang/String;JILchat/ola/vn/entity/ah;)Lchat/ola/vn/message/s;

    move-result-object v2

    const/4 v3, 0x2

    invoke-virtual {v2, v3}, Lchat/ola/vn/message/s;->a(B)V

    invoke-virtual {v0, v2, v1}, Lchat/ola/vn/message/f;->a(Lchat/ola/vn/message/d;Z)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    iput-object v1, v0, Lchat/ola/vn/message/f;->K:Ljava/lang/Long;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :cond_1
    :try_start_2
    invoke-virtual {p0}, Lchat/ola/vn/tradingvip/d;->e()Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->finish()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    return-void
.end method


# virtual methods
.method protected b(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/tradingvip/a;->b(Landroid/os/Bundle;)V

    return-void
.end method

.method public c()Lchat/ola/vn/tradingvip/a;
    .locals 1

    const/4 v0, 0x0

    return-object v0
.end method

.method public e_()Ljava/lang/String;
    .locals 1

    const v0, 0x7f0f048b

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public onClick(Landroid/view/View;)V
    .locals 1

    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f0901ee

    if-eq p1, v0, :cond_1

    const v0, 0x7f090399

    if-eq p1, v0, :cond_0

    const v0, 0x7f09039c

    if-eq p1, v0, :cond_1

    return-void

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/tradingvip/d;->x()V

    return-void

    :cond_1
    invoke-virtual {p0}, Lchat/ola/vn/tradingvip/d;->e()Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/tradingvip/OlaTraddingVipActivity;->C()Lchat/ola/vn/tradingvip/a;

    return-void
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 0

    const p2, 0x7f0b0178

    const/4 p3, 0x0

    invoke-virtual {p1, p2, p3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    const p2, 0x7f090409

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/tradingvip/d;->d:Landroid/widget/TextView;

    const p2, 0x7f090405

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/tradingvip/d;->e:Landroid/widget/TextView;

    const p2, 0x7f0902c2

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/tradingvip/d;->f:Landroid/widget/TextView;

    const p2, 0x7f0905ee

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/tradingvip/d;->g:Landroid/widget/TextView;

    const p2, 0x7f0905f7

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/TextView;

    iput-object p2, p0, Lchat/ola/vn/tradingvip/d;->h:Landroid/widget/TextView;

    const p2, 0x7f09040a

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object p2, p0, Lchat/ola/vn/tradingvip/d;->i:Lchat/ola/vn/view/OlaCachedImageView;

    const p2, 0x7f0905ef

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    check-cast p2, Landroid/widget/ImageView;

    iput-object p2, p0, Lchat/ola/vn/tradingvip/d;->j:Landroid/widget/ImageView;

    const p2, 0x7f090399

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    invoke-virtual {p2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p2, 0x7f0901ee

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p2

    invoke-virtual {p2, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-object p1
.end method

.method public onResume()V
    .locals 0

    invoke-super {p0}, Lchat/ola/vn/tradingvip/a;->onResume()V

    invoke-direct {p0}, Lchat/ola/vn/tradingvip/d;->v()V

    return-void
.end method

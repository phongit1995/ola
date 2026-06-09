.class public Lchat/ola/vn/b/l$a;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/b/l;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "a"
.end annotation


# instance fields
.field protected a:Lchat/ola/vn/view/OlaCachedImageView;

.field protected b:Landroid/widget/TextView;

.field protected c:Landroid/widget/TextView;

.field protected d:Landroid/widget/TextView;

.field protected e:Landroid/view/View;

.field final synthetic f:Lchat/ola/vn/b/l;

.field private g:Lchat/ola/vn/message/f;

.field private h:Landroid/view/View;


# direct methods
.method protected constructor <init>(Lchat/ola/vn/b/l;Landroid/view/View;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/l$a;->f:Lchat/ola/vn/b/l;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const p1, 0x7f0903e3

    :try_start_0
    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object p1, p0, Lchat/ola/vn/b/l$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    const p1, 0x7f0901b9

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/b/l$a;->b:Landroid/widget/TextView;

    const p1, 0x7f090057

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/b/l$a;->c:Landroid/widget/TextView;

    const p1, 0x7f090247

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/b/l$a;->d:Landroid/widget/TextView;

    const p1, 0x7f09008b

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/b/l$a;->e:Landroid/view/View;

    const p1, 0x7f0902c5

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/b/l$a;->h:Landroid/view/View;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method


# virtual methods
.method protected a(Lchat/ola/vn/message/f;)V
    .locals 5

    :try_start_0
    iput-object p1, p0, Lchat/ola/vn/b/l$a;->g:Lchat/ola/vn/message/f;

    iget-object p1, p0, Lchat/ola/vn/b/l$a;->g:Lchat/ola/vn/message/f;

    if-nez p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/b/l$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    const v0, 0x7f0806a5

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setImageResource(I)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/b/l$a;->f:Lchat/ola/vn/b/l;

    iget-object p1, p1, Lchat/ola/vn/b/l;->b:Landroid/view/View$OnClickListener;

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/b/l$a;->e:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/b/l$a;->g:Lchat/ola/vn/message/f;

    invoke-virtual {p1, v0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object p1, p0, Lchat/ola/vn/b/l$a;->e:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/b/l$a;->f:Lchat/ola/vn/b/l;

    iget-object v0, v0, Lchat/ola/vn/b/l;->b:Landroid/view/View$OnClickListener;

    invoke-virtual {p1, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/b/l$a;->h:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/b/l$a;->g:Lchat/ola/vn/message/f;

    invoke-virtual {p1, v0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object p1, p0, Lchat/ola/vn/b/l$a;->h:Landroid/view/View;

    iget-object v0, p0, Lchat/ola/vn/b/l$a;->f:Lchat/ola/vn/b/l;

    iget-object v0, v0, Lchat/ola/vn/b/l;->b:Landroid/view/View$OnClickListener;

    invoke-virtual {p1, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/b/l$a;->d:Landroid/widget/TextView;

    iget-object v0, p0, Lchat/ola/vn/b/l$a;->g:Lchat/ola/vn/message/f;

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setTag(Ljava/lang/Object;)V

    iget-object p1, p0, Lchat/ola/vn/b/l$a;->d:Landroid/widget/TextView;

    iget-object v0, p0, Lchat/ola/vn/b/l$a;->f:Lchat/ola/vn/b/l;

    iget-object v0, v0, Lchat/ola/vn/b/l;->b:Landroid/view/View$OnClickListener;

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/b/l$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v0, 0x0

    if-eqz p1, :cond_2

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object p1

    iget-object v1, p0, Lchat/ola/vn/b/l$a;->g:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/b/l$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p1, v1, v0, v2}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;ZLchat/ola/vn/view/OlaCachedImageView;)V

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/b/l$a;->d:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const v2, 0x7f0f03ad

    invoke-static {v2}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, " "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lchat/ola/vn/b/l$a;->g:Lchat/ola/vn/message/f;

    invoke-virtual {v2}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/b/l$a;->b:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/b/l$a;->g:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->L()Ljava/lang/CharSequence;

    move-result-object v1

    invoke-virtual {p1, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    const-wide/16 v1, 0x0

    iget-object p1, p0, Lchat/ola/vn/b/l$a;->g:Lchat/ola/vn/message/f;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->f()J

    move-result-wide v3

    cmp-long p1, v1, v3

    const/16 v1, 0x8

    if-eqz p1, :cond_4

    iget-object p1, p0, Lchat/ola/vn/b/l$a;->c:Landroid/widget/TextView;

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/b/l$a;->g:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->f()J

    move-result-wide v2

    invoke-virtual {p1, v2, v3}, Ljava/util/Calendar;->setTimeInMillis(J)V

    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Ljava/util/Calendar;->get(I)I

    move-result v2

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    invoke-virtual {p1, v3, v4}, Ljava/util/Calendar;->setTimeInMillis(J)V

    invoke-virtual {p1, v0}, Ljava/util/Calendar;->get(I)I

    move-result p1

    sub-int/2addr p1, v2

    if-lez p1, :cond_3

    const/16 v0, 0x64

    if-ge p1, v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/b/l$a;->c:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string p1, " years old"

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_3
    :goto_0
    iget-object p1, p0, Lchat/ola/vn/b/l$a;->c:Landroid/widget/TextView;

    invoke-virtual {p1, v1}, Landroid/widget/TextView;->setVisibility(I)V

    return-void

    :cond_4
    iget-object p1, p0, Lchat/ola/vn/b/l$a;->c:Landroid/widget/TextView;

    const-string v0, ""

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    return-void
.end method

.class public Lchat/ola/vn/activity/OlaUserProfileActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/app/DatePickerDialog$OnDateSetListener;
.implements Landroid/view/View$OnClickListener;


# instance fields
.field private e:Landroid/widget/TextView;

.field private f:Landroid/widget/EditText;

.field private g:Landroid/widget/TextView;

.field private h:Landroid/widget/TextView;

.field private i:Landroid/widget/TextView;

.field private j:Landroid/widget/EditText;

.field private k:Landroid/widget/TextView;

.field private l:Lchat/ola/vn/entity/ag;

.field private m:Landroid/app/ProgressDialog;

.field private n:Landroid/widget/Button;

.field private o:Z

.field private p:Landroid/widget/ScrollView;

.field private q:Lchat/ola/vn/network/c;

.field private r:Landroid/widget/TextView;

.field private s:Landroid/widget/ImageView;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->o:Z

    new-instance v0, Lchat/ola/vn/activity/OlaUserProfileActivity$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaUserProfileActivity$1;-><init>(Lchat/ola/vn/activity/OlaUserProfileActivity;)V

    iput-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->q:Lchat/ola/vn/network/c;

    return-void
.end method

.method private B()V
    .locals 2

    :try_start_0
    iget-boolean v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->o:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->n:Landroid/widget/Button;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->n:Landroid/widget/Button;

    const v1, 0x7f0f0674

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setText(I)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->n:Landroid/widget/Button;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->n:Landroid/widget/Button;

    const v1, 0x7f0f053c

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaUserProfileActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method private C()V
    .locals 10

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->e:Landroid/widget/TextView;

    const v1, 0x7f0f0666

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->h:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->i:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->l:Lchat/ola/vn/entity/ag;

    if-eqz v0, :cond_9

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaUserProfileActivity;->B()V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->l:Lchat/ola/vn/entity/ag;

    iget-object v0, v0, Lchat/ola/vn/entity/ag;->f:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x1

    const/16 v2, 0x8

    const/4 v3, 0x0

    if-nez v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->f:Landroid/widget/EditText;

    invoke-virtual {v0, v3}, Landroid/widget/EditText;->setEnabled(Z)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->f:Landroid/widget/EditText;

    iget-object v4, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->l:Lchat/ola/vn/entity/ag;

    iget-object v4, v4, Lchat/ola/vn/entity/ag;->f:Ljava/lang/String;

    invoke-virtual {v0, v4}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->g:Landroid/widget/TextView;

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->l:Lchat/ola/vn/entity/ag;

    iget-boolean v0, v0, Lchat/ola/vn/entity/ag;->B:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->s:Landroid/widget/ImageView;

    const v4, 0x7f080720

    invoke-virtual {v0, v4}, Landroid/widget/ImageView;->setImageResource(I)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->s:Landroid/widget/ImageView;

    const v4, 0x7f080633

    invoke-virtual {v0, v4}, Landroid/widget/ImageView;->setImageResource(I)V

    :goto_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->l:Lchat/ola/vn/entity/ag;

    iget-boolean v0, v0, Lchat/ola/vn/entity/ag;->x:Z

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->g:Landroid/widget/TextView;

    sget v2, Lchat/ola/vn/f;->H:I

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->g:Landroid/widget/TextView;

    const v2, 0x7f0f02e5

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(I)V

    goto :goto_2

    :cond_1
    invoke-static {}, Lchat/ola/vn/activity/OlaUserProfileActivity;->x()Z

    move-result v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->g:Landroid/widget/TextView;

    sget v2, Lchat/ola/vn/f;->k:I

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->g:Landroid/widget/TextView;

    const v2, 0x7f0f02e3

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(I)V

    goto :goto_2

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->g:Landroid/widget/TextView;

    :goto_1
    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    goto :goto_2

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->f:Landroid/widget/EditText;

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setEnabled(Z)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->g:Landroid/widget/TextView;

    goto :goto_1

    :goto_2
    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->l:Lchat/ola/vn/entity/ag;

    iget-wide v4, v0, Lchat/ola/vn/entity/ag;->l:J

    const-wide/16 v6, 0x0

    cmp-long v0, v4, v6

    const v2, 0x7f0f0673

    if-eqz v0, :cond_4

    new-instance v0, Ljava/text/SimpleDateFormat;

    const-string v4, "dd/MM/yyyy"

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v5

    invoke-direct {v0, v4, v5}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    iget-object v4, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->e:Landroid/widget/TextView;

    new-instance v5, Ljava/util/Date;

    iget-object v8, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->l:Lchat/ola/vn/entity/ag;

    iget-wide v8, v8, Lchat/ola/vn/entity/ag;->l:J

    invoke-direct {v5, v8, v9}, Ljava/util/Date;-><init>(J)V

    invoke-virtual {v0, v5}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v4, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_3

    :cond_4
    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->e:Landroid/widget/TextView;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(I)V

    :goto_3
    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->l:Lchat/ola/vn/entity/ag;

    iget-wide v4, v0, Lchat/ola/vn/entity/ag;->m:J

    cmp-long v0, v4, v6

    if-eqz v0, :cond_5

    new-instance v0, Ljava/text/SimpleDateFormat;

    const-string v2, "dd/MM/yyyy"

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v4

    invoke-direct {v0, v2, v4}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    iget-object v2, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->k:Landroid/widget/TextView;

    new-instance v4, Ljava/util/Date;

    iget-object v5, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->l:Lchat/ola/vn/entity/ag;

    iget-wide v5, v5, Lchat/ola/vn/entity/ag;->m:J

    invoke-direct {v4, v5, v6}, Ljava/util/Date;-><init>(J)V

    invoke-virtual {v0, v4}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_4

    :cond_5
    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->k:Landroid/widget/TextView;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(I)V

    :goto_4
    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->l:Lchat/ola/vn/entity/ag;

    iget-object v0, v0, Lchat/ola/vn/entity/ag;->k:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_6

    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->j:Landroid/widget/EditText;

    const-string v2, ""

    invoke-virtual {v0, v2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->j:Landroid/widget/EditText;

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setEnabled(Z)V

    goto :goto_5

    :cond_6
    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->j:Landroid/widget/EditText;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->l:Lchat/ola/vn/entity/ag;

    iget-object v1, v1, Lchat/ola/vn/entity/ag;->k:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->j:Landroid/widget/EditText;

    invoke-virtual {v0, v3}, Landroid/widget/EditText;->setEnabled(Z)V

    :goto_5
    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->l:Lchat/ola/vn/entity/ag;

    iget-object v0, v0, Lchat/ola/vn/entity/ag;->e:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_7

    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->h:Landroid/widget/TextView;

    const v1, 0x7f0f062f

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    goto :goto_6

    :cond_7
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const v1, 0x7f0f0555

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaUserProfileActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, " @"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->l:Lchat/ola/vn/entity/ag;

    iget-object v1, v1, Lchat/ola/vn/entity/ag;->e:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->h:Landroid/widget/TextView;

    invoke-static {v0}, Lchat/ola/vn/util/i;->c(Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :goto_6
    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->l:Lchat/ola/vn/entity/ag;

    iget-byte v0, v0, Lchat/ola/vn/entity/ag;->w:B

    packed-switch v0, :pswitch_data_0

    goto :goto_8

    :pswitch_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->i:Landroid/widget/TextView;

    const v1, 0x7f0f04f7

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->i:Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/f;->y:I

    :goto_7
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    goto :goto_8

    :pswitch_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->i:Landroid/widget/TextView;

    const v1, 0x7f0f0552

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->i:Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/f;->y:I

    goto :goto_7

    :pswitch_2
    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->i:Landroid/widget/TextView;

    const v1, 0x7f0f04ef

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->i:Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/f;->y:I

    goto :goto_7

    :pswitch_3
    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->i:Landroid/widget/TextView;

    const v1, 0x7f0f0107

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->i:Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/f;->k:I

    goto :goto_7

    :goto_8
    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v0

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/e;->m(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    invoke-static {v0}, Lchat/ola/vn/h;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_8

    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->r:Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/f;->k:I

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->r:Landroid/widget/TextView;

    const v1, 0x7f0f010a

    :goto_9
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    return-void

    :cond_8
    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->r:Landroid/widget/TextView;

    sget v1, Lchat/ola/vn/f;->y:I

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->r:Landroid/widget/TextView;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    const v1, 0x7f0f0642

    goto :goto_9

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :catch_1
    :cond_9
    return-void

    nop

    :pswitch_data_0
    .packed-switch -0x1
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private D()V
    .locals 2

    const v0, 0x7f0f050e

    const v1, 0x7f0f0190

    :try_start_0
    invoke-static {p0, v0, v1}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;II)Landroid/app/Dialog;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private E()V
    .locals 7

    const v0, 0x7f0f00a2

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaUserProfileActivity;->getString(I)Ljava/lang/String;

    move-result-object v2

    const/4 v0, 0x1

    new-array v0, v0, [Ljava/lang/Object;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->l:Lchat/ola/vn/entity/ag;

    iget-object v1, v1, Lchat/ola/vn/entity/ag;->f:Ljava/lang/String;

    const/4 v3, 0x0

    aput-object v1, v0, v3

    const v1, 0x7f0f0338

    invoke-virtual {p0, v1, v0}, Lchat/ola/vn/activity/OlaUserProfileActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const v0, 0x7f0f0676

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaUserProfileActivity;->getString(I)Ljava/lang/String;

    move-result-object v4

    const v0, 0x7f0f0480

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaUserProfileActivity;->getString(I)Ljava/lang/String;

    move-result-object v5

    new-instance v6, Lchat/ola/vn/activity/OlaUserProfileActivity$6;

    invoke-direct {v6, p0}, Lchat/ola/vn/activity/OlaUserProfileActivity$6;-><init>(Lchat/ola/vn/activity/OlaUserProfileActivity;)V

    move-object v1, p0

    invoke-static/range {v1 .. v6}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/e;

    return-void
.end method

.method private F()V
    .locals 0

    invoke-static {p0}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->a(Landroid/content/Context;)V

    return-void
.end method

.method private G()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->m:Landroid/app/ProgressDialog;

    if-nez v0, :cond_0

    const v0, 0x7f0f05ad

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaUserProfileActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    const v1, 0x7f0f00da

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaUserProfileActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {p0, v0, v1}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/ProgressDialog;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->m:Landroid/app/ProgressDialog;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->m:Landroid/app/ProgressDialog;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/app/ProgressDialog;->setCancelable(Z)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->m:Landroid/app/ProgressDialog;

    invoke-virtual {v0, v1}, Landroid/app/ProgressDialog;->setCanceledOnTouchOutside(Z)V

    :cond_0
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lchat/ola/vn/activity/OlaUserProfileActivity$8;

    invoke-direct {v2, p0}, Lchat/ola/vn/activity/OlaUserProfileActivity$8;-><init>(Lchat/ola/vn/activity/OlaUserProfileActivity;)V

    invoke-static {v2}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v2

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;S)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->m:Landroid/app/ProgressDialog;

    invoke-virtual {v0}, Landroid/app/ProgressDialog;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaUserProfileActivity;Lchat/ola/vn/entity/ag;)Lchat/ola/vn/entity/ag;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->l:Lchat/ola/vn/entity/ag;

    return-object p1
.end method

.method public static a(Landroid/content/Context;)V
    .locals 2

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lchat/ola/vn/activity/OlaUserProfileActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/high16 v1, 0x20000

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    return-void
.end method

.method private a(Landroid/view/View;)V
    .locals 2

    :try_start_0
    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    const v0, 0x7f0f0552

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaUserProfileActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v0, 0x7f0f04ef

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaUserProfileActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v0, 0x7f0f04f7

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaUserProfileActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v0, Lchat/ola/vn/i/m;

    invoke-direct {v0, p0}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0, p1}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v1, Lchat/ola/vn/activity/OlaUserProfileActivity$7;

    invoke-direct {v1, p0, p1}, Lchat/ola/vn/activity/OlaUserProfileActivity$7;-><init>(Lchat/ola/vn/activity/OlaUserProfileActivity;Ljava/util/List;)V

    invoke-virtual {v0, v1}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v0}, Lchat/ola/vn/i/m;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaUserProfileActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaUserProfileActivity;->B()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaUserProfileActivity;Z)Z
    .locals 0

    iput-boolean p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->o:Z

    return p1
.end method

.method static synthetic b(Lchat/ola/vn/activity/OlaUserProfileActivity;)Landroid/widget/EditText;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->j:Landroid/widget/EditText;

    return-object p0
.end method

.method static synthetic c(Lchat/ola/vn/activity/OlaUserProfileActivity;)Landroid/widget/EditText;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->f:Landroid/widget/EditText;

    return-object p0
.end method

.method static synthetic d(Lchat/ola/vn/activity/OlaUserProfileActivity;)Lchat/ola/vn/network/c;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->q:Lchat/ola/vn/network/c;

    return-object p0
.end method

.method static synthetic e(Lchat/ola/vn/activity/OlaUserProfileActivity;)Lchat/ola/vn/entity/ag;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->l:Lchat/ola/vn/entity/ag;

    return-object p0
.end method

.method static synthetic f(Lchat/ola/vn/activity/OlaUserProfileActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaUserProfileActivity;->C()V

    return-void
.end method

.method private f(Ljava/lang/String;)V
    .locals 7

    const v0, 0x7f0f009b

    invoke-virtual {p0, v0}, Lchat/ola/vn/activity/OlaUserProfileActivity;->getString(I)Ljava/lang/String;

    move-result-object v2

    const/4 v0, 0x1

    new-array v0, v0, [Ljava/lang/Object;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "@"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const/4 v1, 0x0

    aput-object p1, v0, v1

    const p1, 0x7f0f0234

    invoke-virtual {p0, p1, v0}, Lchat/ola/vn/activity/OlaUserProfileActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const p1, 0x7f0f06c2

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaUserProfileActivity;->getString(I)Ljava/lang/String;

    move-result-object v4

    const p1, 0x7f0f0577

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaUserProfileActivity;->getString(I)Ljava/lang/String;

    move-result-object v5

    new-instance v6, Lchat/ola/vn/activity/OlaUserProfileActivity$5;

    invoke-direct {v6, p0}, Lchat/ola/vn/activity/OlaUserProfileActivity$5;-><init>(Lchat/ola/vn/activity/OlaUserProfileActivity;)V

    move-object v1, p0

    invoke-static/range {v1 .. v6}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;

    return-void
.end method

.method static synthetic g(Lchat/ola/vn/activity/OlaUserProfileActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaUserProfileActivity;->D()V

    return-void
.end method

.method static synthetic h(Lchat/ola/vn/activity/OlaUserProfileActivity;)Landroid/widget/TextView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->i:Landroid/widget/TextView;

    return-object p0
.end method

.method static synthetic i(Lchat/ola/vn/activity/OlaUserProfileActivity;)Landroid/app/ProgressDialog;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->m:Landroid/app/ProgressDialog;

    return-object p0
.end method

.method static synthetic j(Lchat/ola/vn/activity/OlaUserProfileActivity;)Landroid/widget/ScrollView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->p:Landroid/widget/ScrollView;

    return-object p0
.end method


# virtual methods
.method protected a()V
    .locals 4

    :try_start_0
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaUserProfileActivity;->G()V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaUserProfileActivity;->C()V

    invoke-static {}, Lchat/ola/vn/activity/OlaUserProfileActivity;->x()Z

    move-result v0

    if-eqz v0, :cond_1

    sget-object v0, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-object v0, v0, Lchat/ola/vn/entity/ag;->f:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    sget-object v0, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    iget-boolean v0, v0, Lchat/ola/vn/entity/ag;->x:Z

    if-nez v0, :cond_1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->p:Landroid/widget/ScrollView;

    new-instance v1, Lchat/ola/vn/activity/OlaUserProfileActivity$9;

    invoke-direct {v1, p0}, Lchat/ola/vn/activity/OlaUserProfileActivity$9;-><init>(Lchat/ola/vn/activity/OlaUserProfileActivity;)V

    const-wide/16 v2, 0xfa

    invoke-virtual {v0, v1, v2, v3}, Landroid/widget/ScrollView;->postDelayed(Ljava/lang/Runnable;J)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method

.method public finish()V
    .locals 2

    invoke-super {p0}, Lchat/ola/vn/c;->finish()V

    const v0, 0x7f01003a

    const v1, 0x7f01003b

    :try_start_0
    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/activity/OlaUserProfileActivity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 10

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    const/4 v1, 0x1

    sparse-switch v0, :sswitch_data_0

    return-void

    :sswitch_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->l:Lchat/ola/vn/entity/ag;

    iget-byte v0, v0, Lchat/ola/vn/entity/ag;->w:B

    const/4 v1, -0x1

    if-eq v0, v1, :cond_0

    return-void

    :cond_0
    :sswitch_1
    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaUserProfileActivity;->a(Landroid/view/View;)V

    return-void

    :sswitch_2
    iget-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->l:Lchat/ola/vn/entity/ag;

    iget-wide v0, p1, Lchat/ola/vn/entity/ag;->l:J

    const-wide/16 v2, 0x0

    cmp-long p1, v0, v2

    if-nez p1, :cond_9

    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->l:Lchat/ola/vn/entity/ag;

    iget-wide v0, v0, Lchat/ola/vn/entity/ag;->l:J

    invoke-virtual {p1, v0, v1}, Ljava/util/Calendar;->setTimeInMillis(J)V

    new-instance p1, Landroid/app/DatePickerDialog;

    const/16 v5, 0x7d0

    const/4 v6, 0x5

    const/16 v7, 0xf

    move-object v2, p1

    move-object v3, p0

    move-object v4, p0

    invoke-direct/range {v2 .. v7}, Landroid/app/DatePickerDialog;-><init>(Landroid/content/Context;Landroid/app/DatePickerDialog$OnDateSetListener;III)V

    invoke-virtual {p1}, Landroid/app/DatePickerDialog;->show()V

    return-void

    :sswitch_3
    iget-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->l:Lchat/ola/vn/entity/ag;

    iget-object p1, p1, Lchat/ola/vn/entity/ag;->e:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_1

    invoke-static {p0}, Lchat/ola/vn/activity/MarriageRequestComposerActivity;->a(Landroid/content/Context;)V

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->l:Lchat/ola/vn/entity/ag;

    iget-object p1, p1, Lchat/ola/vn/entity/ag;->e:Ljava/lang/String;

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaUserProfileActivity;->f(Ljava/lang/String;)V

    return-void

    :sswitch_4
    iget-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->l:Lchat/ola/vn/entity/ag;

    iget-object p1, p1, Lchat/ola/vn/entity/ag;->f:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->f:Landroid/widget/EditText;

    invoke-virtual {p1, v1}, Landroid/widget/EditText;->setEnabled(Z)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->f:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->selectAll()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->f:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->requestFocus()Z

    :goto_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->f:Landroid/widget/EditText;

    :goto_1
    invoke-static {p0, p1, v1}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Landroid/view/View;Z)V

    return-void

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->l:Lchat/ola/vn/entity/ag;

    iget-boolean p1, p1, Lchat/ola/vn/entity/ag;->x:Z

    if-nez p1, :cond_9

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaUserProfileActivity;->F()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->f:Landroid/widget/EditText;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/widget/EditText;->setEnabled(Z)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->f:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->clearFocus()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->f:Landroid/widget/EditText;

    invoke-static {p0, p1, v0}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Landroid/view/View;Z)V

    return-void

    :sswitch_5
    iget-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->l:Lchat/ola/vn/entity/ag;

    iget-boolean p1, p1, Lchat/ola/vn/entity/ag;->B:Z

    if-eqz p1, :cond_3

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaUserProfileActivity;->E()V

    return-void

    :cond_3
    iget-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->f:Landroid/widget/EditText;

    invoke-virtual {p1, v1}, Landroid/widget/EditText;->setEnabled(Z)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->f:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->selectAll()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->f:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->requestFocus()Z

    goto :goto_0

    :sswitch_6
    invoke-static {p0}, Lchat/ola/vn/activity/OlaChangePasswordActivity;->a(Landroid/content/Context;)V

    return-void

    :sswitch_7
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaUserProfileActivity;->finish()V

    return-void

    :sswitch_8
    invoke-static {p0}, Lchat/ola/vn/activity/OlaCropImageActivity;->b(Landroid/content/Context;)V

    return-void

    :sswitch_9
    invoke-static {p0}, Lchat/ola/vn/activity/OlaCropImageActivity;->c(Landroid/content/Context;)V

    return-void

    :sswitch_a
    iget-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->j:Landroid/widget/EditText;

    invoke-virtual {p1, v1}, Landroid/widget/EditText;->setEnabled(Z)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->j:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->selectAll()V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->j:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->requestFocus()Z

    iget-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->j:Landroid/widget/EditText;

    goto :goto_1

    :sswitch_b
    invoke-static {p0}, Lcom/mg/ola/common/d/g;->a(Landroid/content/Context;)Z

    move-result p1

    if-eqz p1, :cond_5

    invoke-static {p0}, Lchat/ola/vn/util/n;->b(Landroid/content/Context;)Z

    move-result p1

    if-nez p1, :cond_4

    goto :goto_2

    :cond_4
    const-string p1, "1900588883"

    invoke-static {p0, p1}, Lchat/ola/vn/util/b;->c(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :cond_5
    :goto_2
    invoke-static {p0}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;)V

    return-void

    :sswitch_c
    iget-boolean p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->o:Z

    if-eqz p1, :cond_6

    const v1, 0x7f0f0521

    const v2, 0x7f0f048c

    const v3, 0x7f0f06c2

    const v4, 0x7f0f0577

    new-instance v5, Lchat/ola/vn/activity/OlaUserProfileActivity$3;

    invoke-direct {v5, p0}, Lchat/ola/vn/activity/OlaUserProfileActivity$3;-><init>(Lchat/ola/vn/activity/OlaUserProfileActivity;)V

    move-object v0, p0

    invoke-static/range {v0 .. v5}, Lchat/ola/vn/i/i;->d(Landroid/content/Context;IIIILandroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;

    return-void

    :cond_6
    invoke-static {}, Lcom/facebook/AccessToken;->getCurrentAccessToken()Lcom/facebook/AccessToken;

    move-result-object p1

    if-eqz p1, :cond_8

    invoke-static {}, Lcom/facebook/AccessToken;->getCurrentAccessToken()Lcom/facebook/AccessToken;

    move-result-object p1

    invoke-virtual {p1}, Lcom/facebook/AccessToken;->isExpired()Z

    move-result p1

    if-eqz p1, :cond_7

    goto :goto_3

    :cond_7
    invoke-static {}, Lcom/facebook/AccessToken;->getCurrentAccessToken()Lcom/facebook/AccessToken;

    move-result-object p1

    invoke-virtual {p1}, Lcom/facebook/AccessToken;->getToken()Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->q:Lchat/ola/vn/network/c;

    invoke-static {p1, v0}, Lchat/ola/vn/l/b;->a(Ljava/lang/String;Lchat/ola/vn/network/c;)V

    return-void

    :cond_8
    :goto_3
    const/4 p1, 0x0

    new-instance v0, Lchat/ola/vn/activity/OlaUserProfileActivity$4;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaUserProfileActivity$4;-><init>(Lchat/ola/vn/activity/OlaUserProfileActivity;)V

    invoke-static {p0, p1, v0}, Lchat/ola/vn/activity/OlaFacebookActivity;->a(Landroid/content/Context;Landroid/os/Bundle;Lchat/ola/vn/activity/OlaFacebookActivity$a;)V

    return-void

    :sswitch_d
    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->l:Lchat/ola/vn/entity/ag;

    iget-wide v2, v0, Lchat/ola/vn/entity/ag;->l:J

    invoke-virtual {p1, v2, v3}, Ljava/util/Calendar;->setTimeInMillis(J)V

    new-instance v0, Landroid/app/DatePickerDialog;

    invoke-virtual {p1, v1}, Ljava/util/Calendar;->get(I)I

    move-result v7

    const/4 v1, 0x2

    invoke-virtual {p1, v1}, Ljava/util/Calendar;->get(I)I

    move-result v8

    const/4 v1, 0x5

    invoke-virtual {p1, v1}, Ljava/util/Calendar;->get(I)I

    move-result v9

    move-object v4, v0

    move-object v5, p0

    move-object v6, p0

    invoke-direct/range {v4 .. v9}, Landroid/app/DatePickerDialog;-><init>(Landroid/content/Context;Landroid/app/DatePickerDialog$OnDateSetListener;III)V

    invoke-virtual {v0}, Landroid/app/DatePickerDialog;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_9
    return-void

    nop

    :sswitch_data_0
    .sparse-switch
        0x7f09008d -> :sswitch_d
        0x7f0900dc -> :sswitch_c
        0x7f09011d -> :sswitch_b
        0x7f09023c -> :sswitch_a
        0x7f090240 -> :sswitch_1
        0x7f090262 -> :sswitch_9
        0x7f090271 -> :sswitch_8
        0x7f0903a1 -> :sswitch_7
        0x7f0903bd -> :sswitch_6
        0x7f0903c1 -> :sswitch_5
        0x7f0903c4 -> :sswitch_4
        0x7f0903c5 -> :sswitch_4
        0x7f090543 -> :sswitch_3
        0x7f090556 -> :sswitch_2
        0x7f090579 -> :sswitch_4
        0x7f09058e -> :sswitch_0
    .end sparse-switch
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 3

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b0186

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaUserProfileActivity;->setContentView(I)V

    const p1, 0x7f090556

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaUserProfileActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->e:Landroid/widget/TextView;

    const p1, 0x7f09008d

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaUserProfileActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f090543

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaUserProfileActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->h:Landroid/widget/TextView;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->h:Landroid/widget/TextView;

    invoke-virtual {p1, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f0903c4

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaUserProfileActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f090579

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaUserProfileActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/EditText;

    iput-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->f:Landroid/widget/EditText;

    const p1, 0x7f0903c5

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaUserProfileActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->g:Landroid/widget/TextView;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->g:Landroid/widget/TextView;

    invoke-virtual {p1, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f0903c1

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaUserProfileActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/ImageView;

    iput-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->s:Landroid/widget/ImageView;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->s:Landroid/widget/ImageView;

    invoke-virtual {p1, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f09058e

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaUserProfileActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->i:Landroid/widget/TextView;

    const p1, 0x7f090240

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaUserProfileActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f09052b

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaUserProfileActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->k:Landroid/widget/TextView;

    const p1, 0x7f09023d

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaUserProfileActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/EditText;

    iput-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->j:Landroid/widget/EditText;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->j:Landroid/widget/EditText;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/widget/EditText;->setEnabled(Z)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->j:Landroid/widget/EditText;

    invoke-virtual {p1, p0}, Landroid/widget/EditText;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f09023c

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaUserProfileActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f09044b

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaUserProfileActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/ScrollView;

    iput-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->p:Landroid/widget/ScrollView;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->p:Landroid/widget/ScrollView;

    new-instance v1, Lchat/ola/vn/activity/OlaUserProfileActivity$2;

    invoke-direct {v1, p0}, Lchat/ola/vn/activity/OlaUserProfileActivity$2;-><init>(Lchat/ola/vn/activity/OlaUserProfileActivity;)V

    invoke-virtual {p1, v1}, Landroid/widget/ScrollView;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->e:Landroid/widget/TextView;

    invoke-virtual {p1, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->f:Landroid/widget/EditText;

    invoke-virtual {p1, p0}, Landroid/widget/EditText;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->i:Landroid/widget/TextView;

    invoke-virtual {p1, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f09011d

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaUserProfileActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/view/View;->setVisibility(I)V

    const v1, 0x7f0903a3

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaUserProfileActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    const v2, 0x7f0f05a0

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(I)V

    const v1, 0x7f09039c

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaUserProfileActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    const/4 v2, 0x4

    invoke-virtual {v1, v2}, Landroid/view/View;->setVisibility(I)V

    const v1, 0x7f0903a1

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaUserProfileActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ImageView;

    invoke-virtual {v1, v0}, Landroid/widget/ImageView;->setVisibility(I)V

    const v2, 0x7f080640

    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setImageResource(I)V

    invoke-virtual {v1, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v1, 0x7f0903bd

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaUserProfileActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v1, 0x7f0903bc

    invoke-virtual {p0, v1}, Lchat/ola/vn/activity/OlaUserProfileActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->r:Landroid/widget/TextView;

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaUserProfileActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f0900dc

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaUserProfileActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Button;

    iput-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->n:Landroid/widget/Button;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->n:Landroid/widget/Button;

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->n:Landroid/widget/Button;

    invoke-virtual {p1, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaUserProfileActivity;->B()V

    return-void
.end method

.method public onDateSet(Landroid/widget/DatePicker;III)V
    .locals 2

    :try_start_0
    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object p1

    const/4 v0, 0x5

    invoke-virtual {p1, v0, p4}, Ljava/util/Calendar;->set(II)V

    const/4 p4, 0x2

    invoke-virtual {p1, p4, p3}, Ljava/util/Calendar;->set(II)V

    const/4 p3, 0x1

    invoke-virtual {p1, p3, p2}, Ljava/util/Calendar;->set(II)V

    invoke-virtual {p1}, Ljava/util/Calendar;->getTimeInMillis()J

    move-result-wide p1

    iget-object p3, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->l:Lchat/ola/vn/entity/ag;

    invoke-static {p1, p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p4

    invoke-virtual {p4}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    iput-wide v0, p3, Lchat/ola/vn/entity/ag;->l:J

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaUserProfileActivity;->C()V

    sget-object p3, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {p1, p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p1

    const/4 p2, 0x0

    invoke-virtual {p3, p2, p2, p1, p2}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Long;Ljava/lang/Byte;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onPause()V
    .locals 5

    invoke-super {p0}, Lchat/ola/vn/c;->onPause()V

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->l:Lchat/ola/vn/entity/ag;

    iget-wide v0, v0, Lchat/ola/vn/entity/ag;->l:J

    const-wide/16 v2, 0x0

    cmp-long v4, v0, v2

    const/4 v0, 0x0

    if-eqz v4, :cond_0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->l:Lchat/ola/vn/entity/ag;

    iget-wide v1, v1, Lchat/ola/vn/entity/ag;->l:J

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    goto :goto_0

    :cond_0
    move-object v1, v0

    :goto_0
    iget-object v2, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->l:Lchat/ola/vn/entity/ag;

    iget-byte v2, v2, Lchat/ola/vn/entity/ag;->w:B

    const/4 v3, -0x1

    if-eq v2, v3, :cond_1

    iget-object v2, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->l:Lchat/ola/vn/entity/ag;

    iget-byte v2, v2, Lchat/ola/vn/entity/ag;->w:B

    invoke-static {v2}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object v2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_2

    goto :goto_1

    :cond_1
    move-object v2, v0

    :goto_1
    :try_start_1
    iget-object v3, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->j:Landroid/widget/EditText;

    invoke-virtual {v3}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v3
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_2

    :catch_0
    move-object v3, v0

    :goto_2
    :try_start_2
    iget-object v4, p0, Lchat/ola/vn/activity/OlaUserProfileActivity;->f:Landroid/widget/EditText;

    invoke-virtual {v4}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v4
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    move-object v0, v4

    :catch_1
    :try_start_3
    sget-object v4, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v4, v3, v0, v1, v2}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Long;Ljava/lang/Byte;)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_2

    :catch_2
    return-void
.end method

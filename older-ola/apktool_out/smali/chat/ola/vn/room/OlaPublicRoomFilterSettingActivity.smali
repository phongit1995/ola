.class public Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Landroid/widget/CompoundButton$OnCheckedChangeListener;


# instance fields
.field private e:Landroid/widget/CheckBox;

.field private f:Landroid/widget/CheckBox;

.field private g:Landroid/widget/CheckBox;

.field private h:Landroid/widget/CheckBox;

.field private i:Landroid/widget/CheckBox;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    return-void
.end method

.method private B()V
    .locals 2

    const v0, 0x7f0903a3

    invoke-virtual {p0, v0}, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    const v1, 0x7f0f0606

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    const v0, 0x7f09039c

    invoke-virtual {p0, v0}, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    const v1, 0x7f0f042c

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    invoke-virtual {v0, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const v0, 0x7f090219

    invoke-virtual {p0, v0}, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/CheckBox;

    iput-object v0, p0, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->e:Landroid/widget/CheckBox;

    iget-object v0, p0, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->e:Landroid/widget/CheckBox;

    invoke-virtual {v0, p0}, Landroid/widget/CheckBox;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    const v0, 0x7f090218

    invoke-virtual {p0, v0}, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/CheckBox;

    iput-object v0, p0, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->f:Landroid/widget/CheckBox;

    iget-object v0, p0, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->f:Landroid/widget/CheckBox;

    invoke-virtual {v0, p0}, Landroid/widget/CheckBox;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    const v0, 0x7f090215

    invoke-virtual {p0, v0}, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/CheckBox;

    iput-object v0, p0, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->g:Landroid/widget/CheckBox;

    iget-object v0, p0, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->g:Landroid/widget/CheckBox;

    invoke-virtual {v0, p0}, Landroid/widget/CheckBox;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    const v0, 0x7f090217

    invoke-virtual {p0, v0}, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/CheckBox;

    iput-object v0, p0, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->h:Landroid/widget/CheckBox;

    iget-object v0, p0, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->h:Landroid/widget/CheckBox;

    invoke-virtual {v0, p0}, Landroid/widget/CheckBox;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    const v0, 0x7f090216

    invoke-virtual {p0, v0}, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/CheckBox;

    iput-object v0, p0, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->i:Landroid/widget/CheckBox;

    iget-object v0, p0, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->i:Landroid/widget/CheckBox;

    invoke-virtual {v0, p0}, Landroid/widget/CheckBox;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    return-void
.end method

.method private C()V
    .locals 4

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/f;->q()S

    move-result v0

    sget-object v1, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v1}, Lchat/ola/vn/r/a/f;->r()Z

    move-result v1

    const/4 v2, 0x1

    if-nez v1, :cond_0

    iget-object v0, p0, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->e:Landroid/widget/CheckBox;

    :goto_0
    invoke-virtual {v0, v2}, Landroid/widget/CheckBox;->setChecked(Z)V

    return-void

    :cond_0
    sget-short v1, Lchat/ola/vn/r/a/f;->d:S

    and-int/2addr v1, v0

    sget-short v3, Lchat/ola/vn/r/a/f;->d:S

    if-ne v1, v3, :cond_1

    iget-object v1, p0, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->f:Landroid/widget/CheckBox;

    invoke-virtual {v1, v2}, Landroid/widget/CheckBox;->setChecked(Z)V

    :cond_1
    sget-short v1, Lchat/ola/vn/r/a/f;->a:S

    and-int/2addr v1, v0

    sget-short v3, Lchat/ola/vn/r/a/f;->a:S

    if-ne v1, v3, :cond_2

    iget-object v1, p0, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->g:Landroid/widget/CheckBox;

    invoke-virtual {v1, v2}, Landroid/widget/CheckBox;->setChecked(Z)V

    :cond_2
    sget-short v1, Lchat/ola/vn/r/a/f;->b:S

    and-int/2addr v1, v0

    sget-short v3, Lchat/ola/vn/r/a/f;->b:S

    if-ne v1, v3, :cond_3

    iget-object v1, p0, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->h:Landroid/widget/CheckBox;

    invoke-virtual {v1, v2}, Landroid/widget/CheckBox;->setChecked(Z)V

    :cond_3
    sget-short v1, Lchat/ola/vn/r/a/f;->c:S

    and-int/2addr v0, v1

    sget-short v1, Lchat/ola/vn/r/a/f;->c:S

    if-ne v0, v1, :cond_4

    iget-object v0, p0, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->i:Landroid/widget/CheckBox;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    :cond_4
    return-void
.end method

.method private D()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->f:Landroid/widget/CheckBox;

    invoke-virtual {v0}, Landroid/widget/CheckBox;->isChecked()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->g:Landroid/widget/CheckBox;

    invoke-virtual {v0}, Landroid/widget/CheckBox;->isChecked()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->h:Landroid/widget/CheckBox;

    invoke-virtual {v0}, Landroid/widget/CheckBox;->isChecked()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->i:Landroid/widget/CheckBox;

    invoke-virtual {v0}, Landroid/widget/CheckBox;->isChecked()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->e:Landroid/widget/CheckBox;

    invoke-virtual {v0}, Landroid/widget/CheckBox;->isChecked()Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->e:Landroid/widget/CheckBox;

    const/4 v1, 0x1

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->e:Landroid/widget/CheckBox;

    invoke-virtual {v0}, Landroid/widget/CheckBox;->isChecked()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->e:Landroid/widget/CheckBox;

    const/4 v1, 0x0

    :goto_0
    invoke-virtual {v0, v1}, Landroid/widget/CheckBox;->setChecked(Z)V

    :cond_1
    return-void
.end method

.method private E()V
    .locals 2

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/f;->q()S

    iget-object v0, p0, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->e:Landroid/widget/CheckBox;

    invoke-virtual {v0}, Landroid/widget/CheckBox;->isChecked()Z

    move-result v0

    if-eqz v0, :cond_0

    sget-short v0, Lchat/ola/vn/r/a/f;->e:S

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    iget-object v1, p0, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->f:Landroid/widget/CheckBox;

    invoke-virtual {v1}, Landroid/widget/CheckBox;->isChecked()Z

    move-result v1

    if-eqz v1, :cond_1

    sget-short v1, Lchat/ola/vn/r/a/f;->d:S

    or-int/2addr v0, v1

    int-to-short v0, v0

    :cond_1
    iget-object v1, p0, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->g:Landroid/widget/CheckBox;

    invoke-virtual {v1}, Landroid/widget/CheckBox;->isChecked()Z

    move-result v1

    if-eqz v1, :cond_2

    sget-short v1, Lchat/ola/vn/r/a/f;->a:S

    or-int/2addr v0, v1

    int-to-short v0, v0

    :cond_2
    iget-object v1, p0, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->h:Landroid/widget/CheckBox;

    invoke-virtual {v1}, Landroid/widget/CheckBox;->isChecked()Z

    move-result v1

    if-eqz v1, :cond_3

    sget-short v1, Lchat/ola/vn/r/a/f;->b:S

    or-int/2addr v0, v1

    int-to-short v0, v0

    :cond_3
    iget-object v1, p0, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->i:Landroid/widget/CheckBox;

    invoke-virtual {v1}, Landroid/widget/CheckBox;->isChecked()Z

    move-result v1

    if-eqz v1, :cond_4

    sget-short v1, Lchat/ola/vn/r/a/f;->c:S

    or-int/2addr v0, v1

    int-to-short v0, v0

    :cond_4
    :goto_0
    sget-object v1, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v1, v0}, Lchat/ola/vn/r/a/f;->a(S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static a(Landroid/content/Context;)V
    .locals 2

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    :try_start_0
    check-cast p0, Landroid/app/Activity;

    const v0, 0x7f010038

    const v1, 0x7f010039

    invoke-virtual {p0, v0, v1}, Landroid/app/Activity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method


# virtual methods
.method protected a()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->C()V

    return-void
.end method

.method public finish()V
    .locals 2

    invoke-direct {p0}, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->E()V

    invoke-super {p0}, Lchat/ola/vn/c;->finish()V

    const v0, 0x7f01003a

    const v1, 0x7f01003b

    :try_start_0
    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onCheckedChanged(Landroid/widget/CompoundButton;Z)V
    .locals 0

    :try_start_0
    invoke-virtual {p1}, Landroid/widget/CompoundButton;->getId()I

    move-result p1

    packed-switch p1, :pswitch_data_0

    return-void

    :pswitch_0
    if-eqz p2, :cond_4

    iget-object p1, p0, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->f:Landroid/widget/CheckBox;

    invoke-virtual {p1}, Landroid/widget/CheckBox;->isChecked()Z

    move-result p1

    const/4 p2, 0x1

    if-nez p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->f:Landroid/widget/CheckBox;

    invoke-virtual {p1, p2}, Landroid/widget/CheckBox;->setChecked(Z)V

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->g:Landroid/widget/CheckBox;

    invoke-virtual {p1}, Landroid/widget/CheckBox;->isChecked()Z

    move-result p1

    if-nez p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->g:Landroid/widget/CheckBox;

    invoke-virtual {p1, p2}, Landroid/widget/CheckBox;->setChecked(Z)V

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->h:Landroid/widget/CheckBox;

    invoke-virtual {p1}, Landroid/widget/CheckBox;->isChecked()Z

    move-result p1

    if-nez p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->h:Landroid/widget/CheckBox;

    invoke-virtual {p1, p2}, Landroid/widget/CheckBox;->setChecked(Z)V

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->i:Landroid/widget/CheckBox;

    invoke-virtual {p1}, Landroid/widget/CheckBox;->isChecked()Z

    move-result p1

    if-nez p1, :cond_4

    iget-object p1, p0, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->i:Landroid/widget/CheckBox;

    :goto_0
    invoke-virtual {p1, p2}, Landroid/widget/CheckBox;->setChecked(Z)V

    return-void

    :pswitch_1
    if-nez p2, :cond_3

    iget-object p1, p0, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->e:Landroid/widget/CheckBox;

    const/4 p2, 0x0

    goto :goto_0

    :cond_3
    invoke-direct {p0}, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->D()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_4
    return-void

    :pswitch_data_0
    .packed-switch 0x7f090215
        :pswitch_1
        :pswitch_1
        :pswitch_1
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public onClick(Landroid/view/View;)V
    .locals 1

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f09000f

    if-eq p1, v0, :cond_1

    const v0, 0x7f09039c

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b0165

    invoke-virtual {p0, p1}, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->setContentView(I)V

    invoke-direct {p0}, Lchat/ola/vn/room/OlaPublicRoomFilterSettingActivity;->B()V

    return-void
.end method

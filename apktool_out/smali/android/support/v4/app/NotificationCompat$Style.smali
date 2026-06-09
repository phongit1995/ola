.class public abstract Landroid/support/v4/app/NotificationCompat$Style;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroid/support/v4/app/NotificationCompat;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "Style"
.end annotation


# instance fields
.field mBigContentTitle:Ljava/lang/CharSequence;

.field protected mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;
    .annotation build Landroid/support/annotation/RestrictTo;
        value = {
            .enum Landroid/support/annotation/RestrictTo$Scope;->LIBRARY_GROUP:Landroid/support/annotation/RestrictTo$Scope;
        }
    .end annotation
.end field

.field mSummaryText:Ljava/lang/CharSequence;

.field mSummaryTextSet:Z


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Landroid/support/v4/app/NotificationCompat$Style;->mSummaryTextSet:Z

    return-void
.end method

.method private calculateTopPadding()I
    .locals 5

    iget-object v0, p0, Landroid/support/v4/app/NotificationCompat$Style;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    iget-object v0, v0, Landroid/support/v4/app/NotificationCompat$Builder;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    sget v1, Landroid/support/compat/R$dimen;->notification_top_pad:I

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v1

    sget v2, Landroid/support/compat/R$dimen;->notification_top_pad_large_text:I

    invoke-virtual {v0, v2}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v2

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget v0, v0, Landroid/content/res/Configuration;->fontScale:F

    const/high16 v3, 0x3f800000    # 1.0f

    const v4, 0x3fa66666    # 1.3f

    invoke-static {v0, v3, v4}, Landroid/support/v4/app/NotificationCompat$Style;->constrain(FFF)F

    move-result v0

    sub-float/2addr v0, v3

    const v4, 0x3e999998    # 0.29999995f

    div-float/2addr v0, v4

    sub-float/2addr v3, v0

    int-to-float v1, v1

    mul-float v3, v3, v1

    int-to-float v1, v2

    mul-float v0, v0, v1

    add-float/2addr v3, v0

    invoke-static {v3}, Ljava/lang/Math;->round(F)I

    move-result v0

    return v0
.end method

.method private static constrain(FFF)F
    .locals 1

    cmpg-float v0, p0, p1

    if-gez v0, :cond_0

    move p0, p1

    return p0

    :cond_0
    cmpl-float p1, p0, p2

    if-lez p1, :cond_1

    move p0, p2

    :cond_1
    return p0
.end method

.method private createColoredBitmap(III)Landroid/graphics/Bitmap;
    .locals 3

    iget-object v0, p0, Landroid/support/v4/app/NotificationCompat$Style;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    iget-object v0, v0, Landroid/support/v4/app/NotificationCompat$Builder;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/content/res/Resources;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object p1

    if-nez p3, :cond_0

    invoke-virtual {p1}, Landroid/graphics/drawable/Drawable;->getIntrinsicWidth()I

    move-result v0

    goto :goto_0

    :cond_0
    move v0, p3

    :goto_0
    if-nez p3, :cond_1

    invoke-virtual {p1}, Landroid/graphics/drawable/Drawable;->getIntrinsicHeight()I

    move-result p3

    :cond_1
    sget-object v1, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {v0, p3, v1}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {p1, v2, v2, v0, p3}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    if-eqz p2, :cond_2

    invoke-virtual {p1}, Landroid/graphics/drawable/Drawable;->mutate()Landroid/graphics/drawable/Drawable;

    move-result-object p3

    new-instance v0, Landroid/graphics/PorterDuffColorFilter;

    sget-object v2, Landroid/graphics/PorterDuff$Mode;->SRC_IN:Landroid/graphics/PorterDuff$Mode;

    invoke-direct {v0, p2, v2}, Landroid/graphics/PorterDuffColorFilter;-><init>(ILandroid/graphics/PorterDuff$Mode;)V

    invoke-virtual {p3, v0}, Landroid/graphics/drawable/Drawable;->setColorFilter(Landroid/graphics/ColorFilter;)V

    :cond_2
    new-instance p2, Landroid/graphics/Canvas;

    invoke-direct {p2, v1}, Landroid/graphics/Canvas;-><init>(Landroid/graphics/Bitmap;)V

    invoke-virtual {p1, p2}, Landroid/graphics/drawable/Drawable;->draw(Landroid/graphics/Canvas;)V

    return-object v1
.end method

.method private createIconWithBackground(IIII)Landroid/graphics/Bitmap;
    .locals 2

    sget v0, Landroid/support/compat/R$drawable;->notification_icon_background:I

    if-nez p4, :cond_0

    const/4 p4, 0x0

    :cond_0
    invoke-direct {p0, v0, p4, p2}, Landroid/support/v4/app/NotificationCompat$Style;->createColoredBitmap(III)Landroid/graphics/Bitmap;

    move-result-object p4

    new-instance v0, Landroid/graphics/Canvas;

    invoke-direct {v0, p4}, Landroid/graphics/Canvas;-><init>(Landroid/graphics/Bitmap;)V

    iget-object v1, p0, Landroid/support/v4/app/NotificationCompat$Style;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    iget-object v1, v1, Landroid/support/v4/app/NotificationCompat$Builder;->mContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1, p1}, Landroid/content/res/Resources;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object p1

    invoke-virtual {p1}, Landroid/graphics/drawable/Drawable;->mutate()Landroid/graphics/drawable/Drawable;

    move-result-object p1

    const/4 v1, 0x1

    invoke-virtual {p1, v1}, Landroid/graphics/drawable/Drawable;->setFilterBitmap(Z)V

    sub-int/2addr p2, p3

    div-int/lit8 p2, p2, 0x2

    add-int/2addr p3, p2

    invoke-virtual {p1, p2, p2, p3, p3}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    new-instance p2, Landroid/graphics/PorterDuffColorFilter;

    const/4 p3, -0x1

    sget-object v1, Landroid/graphics/PorterDuff$Mode;->SRC_ATOP:Landroid/graphics/PorterDuff$Mode;

    invoke-direct {p2, p3, v1}, Landroid/graphics/PorterDuffColorFilter;-><init>(ILandroid/graphics/PorterDuff$Mode;)V

    invoke-virtual {p1, p2}, Landroid/graphics/drawable/Drawable;->setColorFilter(Landroid/graphics/ColorFilter;)V

    invoke-virtual {p1, v0}, Landroid/graphics/drawable/Drawable;->draw(Landroid/graphics/Canvas;)V

    return-object p4
.end method

.method private hideNormalContent(Landroid/widget/RemoteViews;)V
    .locals 2

    sget v0, Landroid/support/compat/R$id;->title:I

    const/16 v1, 0x8

    invoke-virtual {p1, v0, v1}, Landroid/widget/RemoteViews;->setViewVisibility(II)V

    sget v0, Landroid/support/compat/R$id;->text2:I

    invoke-virtual {p1, v0, v1}, Landroid/widget/RemoteViews;->setViewVisibility(II)V

    sget v0, Landroid/support/compat/R$id;->text:I

    invoke-virtual {p1, v0, v1}, Landroid/widget/RemoteViews;->setViewVisibility(II)V

    return-void
.end method


# virtual methods
.method public addCompatExtras(Landroid/os/Bundle;)V
    .locals 0
    .annotation build Landroid/support/annotation/RestrictTo;
        value = {
            .enum Landroid/support/annotation/RestrictTo$Scope;->LIBRARY_GROUP:Landroid/support/annotation/RestrictTo$Scope;
        }
    .end annotation

    return-void
.end method

.method public apply(Landroid/support/v4/app/NotificationBuilderWithBuilderAccessor;)V
    .locals 0
    .annotation build Landroid/support/annotation/RestrictTo;
        value = {
            .enum Landroid/support/annotation/RestrictTo$Scope;->LIBRARY_GROUP:Landroid/support/annotation/RestrictTo$Scope;
        }
    .end annotation

    return-void
.end method

.method public applyStandardTemplate(ZIZ)Landroid/widget/RemoteViews;
    .locals 17
    .annotation build Landroid/support/annotation/RestrictTo;
        value = {
            .enum Landroid/support/annotation/RestrictTo$Scope;->LIBRARY_GROUP:Landroid/support/annotation/RestrictTo$Scope;
        }
    .end annotation

    move-object/from16 v0, p0

    iget-object v2, v0, Landroid/support/v4/app/NotificationCompat$Style;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    iget-object v2, v2, Landroid/support/v4/app/NotificationCompat$Builder;->mContext:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    new-instance v9, Landroid/widget/RemoteViews;

    iget-object v3, v0, Landroid/support/v4/app/NotificationCompat$Style;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    iget-object v3, v3, Landroid/support/v4/app/NotificationCompat$Builder;->mContext:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v3

    move/from16 v4, p2

    invoke-direct {v9, v3, v4}, Landroid/widget/RemoteViews;-><init>(Ljava/lang/String;I)V

    iget-object v3, v0, Landroid/support/v4/app/NotificationCompat$Style;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-virtual {v3}, Landroid/support/v4/app/NotificationCompat$Builder;->getPriority()I

    move-result v3

    const/4 v4, -0x1

    const/4 v10, 0x1

    const/4 v11, 0x0

    if-ge v3, v4, :cond_0

    const/4 v3, 0x1

    goto :goto_0

    :cond_0
    const/4 v3, 0x0

    :goto_0
    sget v5, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v6, 0x15

    const/16 v12, 0x10

    if-lt v5, v12, :cond_2

    sget v5, Landroid/os/Build$VERSION;->SDK_INT:I

    if-ge v5, v6, :cond_2

    if-eqz v3, :cond_1

    sget v3, Landroid/support/compat/R$id;->notification_background:I

    const-string v5, "setBackgroundResource"

    sget v7, Landroid/support/compat/R$drawable;->notification_bg_low:I

    invoke-virtual {v9, v3, v5, v7}, Landroid/widget/RemoteViews;->setInt(ILjava/lang/String;I)V

    sget v3, Landroid/support/compat/R$id;->icon:I

    const-string v5, "setBackgroundResource"

    sget v7, Landroid/support/compat/R$drawable;->notification_template_icon_low_bg:I

    :goto_1
    invoke-virtual {v9, v3, v5, v7}, Landroid/widget/RemoteViews;->setInt(ILjava/lang/String;I)V

    goto :goto_2

    :cond_1
    sget v3, Landroid/support/compat/R$id;->notification_background:I

    const-string v5, "setBackgroundResource"

    sget v7, Landroid/support/compat/R$drawable;->notification_bg:I

    invoke-virtual {v9, v3, v5, v7}, Landroid/widget/RemoteViews;->setInt(ILjava/lang/String;I)V

    sget v3, Landroid/support/compat/R$id;->icon:I

    const-string v5, "setBackgroundResource"

    sget v7, Landroid/support/compat/R$drawable;->notification_template_icon_bg:I

    goto :goto_1

    :cond_2
    :goto_2
    iget-object v3, v0, Landroid/support/v4/app/NotificationCompat$Style;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    iget-object v3, v3, Landroid/support/v4/app/NotificationCompat$Builder;->mLargeIcon:Landroid/graphics/Bitmap;

    const/16 v13, 0x8

    if-eqz v3, :cond_5

    sget v3, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt v3, v12, :cond_3

    sget v3, Landroid/support/compat/R$id;->icon:I

    invoke-virtual {v9, v3, v11}, Landroid/widget/RemoteViews;->setViewVisibility(II)V

    sget v3, Landroid/support/compat/R$id;->icon:I

    iget-object v5, v0, Landroid/support/v4/app/NotificationCompat$Style;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    iget-object v5, v5, Landroid/support/v4/app/NotificationCompat$Builder;->mLargeIcon:Landroid/graphics/Bitmap;

    invoke-virtual {v9, v3, v5}, Landroid/widget/RemoteViews;->setImageViewBitmap(ILandroid/graphics/Bitmap;)V

    goto :goto_3

    :cond_3
    sget v3, Landroid/support/compat/R$id;->icon:I

    invoke-virtual {v9, v3, v13}, Landroid/widget/RemoteViews;->setViewVisibility(II)V

    :goto_3
    if-eqz p1, :cond_7

    iget-object v1, v0, Landroid/support/v4/app/NotificationCompat$Style;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    iget-object v1, v1, Landroid/support/v4/app/NotificationCompat$Builder;->mNotification:Landroid/app/Notification;

    iget v1, v1, Landroid/app/Notification;->icon:I

    if-eqz v1, :cond_7

    sget v1, Landroid/support/compat/R$dimen;->notification_right_icon_size:I

    invoke-virtual {v2, v1}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v1

    sget v3, Landroid/support/compat/R$dimen;->notification_small_icon_background_padding:I

    invoke-virtual {v2, v3}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v3

    mul-int/lit8 v3, v3, 0x2

    sub-int v3, v1, v3

    sget v5, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt v5, v6, :cond_4

    iget-object v4, v0, Landroid/support/v4/app/NotificationCompat$Style;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    iget-object v4, v4, Landroid/support/v4/app/NotificationCompat$Builder;->mNotification:Landroid/app/Notification;

    iget v4, v4, Landroid/app/Notification;->icon:I

    iget-object v5, v0, Landroid/support/v4/app/NotificationCompat$Style;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-virtual {v5}, Landroid/support/v4/app/NotificationCompat$Builder;->getColor()I

    move-result v5

    invoke-direct {v0, v4, v1, v3, v5}, Landroid/support/v4/app/NotificationCompat$Style;->createIconWithBackground(IIII)Landroid/graphics/Bitmap;

    move-result-object v1

    sget v3, Landroid/support/compat/R$id;->right_icon:I

    invoke-virtual {v9, v3, v1}, Landroid/widget/RemoteViews;->setImageViewBitmap(ILandroid/graphics/Bitmap;)V

    goto :goto_4

    :cond_4
    sget v1, Landroid/support/compat/R$id;->right_icon:I

    iget-object v3, v0, Landroid/support/v4/app/NotificationCompat$Style;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    iget-object v3, v3, Landroid/support/v4/app/NotificationCompat$Builder;->mNotification:Landroid/app/Notification;

    iget v3, v3, Landroid/app/Notification;->icon:I

    invoke-virtual {v0, v3, v4}, Landroid/support/v4/app/NotificationCompat$Style;->createColoredBitmap(II)Landroid/graphics/Bitmap;

    move-result-object v3

    invoke-virtual {v9, v1, v3}, Landroid/widget/RemoteViews;->setImageViewBitmap(ILandroid/graphics/Bitmap;)V

    :goto_4
    sget v1, Landroid/support/compat/R$id;->right_icon:I

    invoke-virtual {v9, v1, v11}, Landroid/widget/RemoteViews;->setViewVisibility(II)V

    goto :goto_5

    :cond_5
    if-eqz p1, :cond_7

    iget-object v1, v0, Landroid/support/v4/app/NotificationCompat$Style;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    iget-object v1, v1, Landroid/support/v4/app/NotificationCompat$Builder;->mNotification:Landroid/app/Notification;

    iget v1, v1, Landroid/app/Notification;->icon:I

    if-eqz v1, :cond_7

    sget v1, Landroid/support/compat/R$id;->icon:I

    invoke-virtual {v9, v1, v11}, Landroid/widget/RemoteViews;->setViewVisibility(II)V

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt v1, v6, :cond_6

    sget v1, Landroid/support/compat/R$dimen;->notification_large_icon_width:I

    invoke-virtual {v2, v1}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v1

    sget v3, Landroid/support/compat/R$dimen;->notification_big_circle_margin:I

    invoke-virtual {v2, v3}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v3

    sub-int/2addr v1, v3

    sget v3, Landroid/support/compat/R$dimen;->notification_small_icon_size_as_large:I

    invoke-virtual {v2, v3}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v3

    iget-object v4, v0, Landroid/support/v4/app/NotificationCompat$Style;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    iget-object v4, v4, Landroid/support/v4/app/NotificationCompat$Builder;->mNotification:Landroid/app/Notification;

    iget v4, v4, Landroid/app/Notification;->icon:I

    iget-object v5, v0, Landroid/support/v4/app/NotificationCompat$Style;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-virtual {v5}, Landroid/support/v4/app/NotificationCompat$Builder;->getColor()I

    move-result v5

    invoke-direct {v0, v4, v1, v3, v5}, Landroid/support/v4/app/NotificationCompat$Style;->createIconWithBackground(IIII)Landroid/graphics/Bitmap;

    move-result-object v1

    sget v3, Landroid/support/compat/R$id;->icon:I

    invoke-virtual {v9, v3, v1}, Landroid/widget/RemoteViews;->setImageViewBitmap(ILandroid/graphics/Bitmap;)V

    goto :goto_5

    :cond_6
    sget v1, Landroid/support/compat/R$id;->icon:I

    iget-object v3, v0, Landroid/support/v4/app/NotificationCompat$Style;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    iget-object v3, v3, Landroid/support/v4/app/NotificationCompat$Builder;->mNotification:Landroid/app/Notification;

    iget v3, v3, Landroid/app/Notification;->icon:I

    invoke-virtual {v0, v3, v4}, Landroid/support/v4/app/NotificationCompat$Style;->createColoredBitmap(II)Landroid/graphics/Bitmap;

    move-result-object v3

    invoke-virtual {v9, v1, v3}, Landroid/widget/RemoteViews;->setImageViewBitmap(ILandroid/graphics/Bitmap;)V

    :cond_7
    :goto_5
    iget-object v1, v0, Landroid/support/v4/app/NotificationCompat$Style;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    iget-object v1, v1, Landroid/support/v4/app/NotificationCompat$Builder;->mContentTitle:Ljava/lang/CharSequence;

    if-eqz v1, :cond_8

    sget v1, Landroid/support/compat/R$id;->title:I

    iget-object v3, v0, Landroid/support/v4/app/NotificationCompat$Style;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    iget-object v3, v3, Landroid/support/v4/app/NotificationCompat$Builder;->mContentTitle:Ljava/lang/CharSequence;

    invoke-virtual {v9, v1, v3}, Landroid/widget/RemoteViews;->setTextViewText(ILjava/lang/CharSequence;)V

    :cond_8
    iget-object v1, v0, Landroid/support/v4/app/NotificationCompat$Style;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    iget-object v1, v1, Landroid/support/v4/app/NotificationCompat$Builder;->mContentText:Ljava/lang/CharSequence;

    if-eqz v1, :cond_9

    sget v1, Landroid/support/compat/R$id;->text:I

    iget-object v3, v0, Landroid/support/v4/app/NotificationCompat$Style;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    iget-object v3, v3, Landroid/support/v4/app/NotificationCompat$Builder;->mContentText:Ljava/lang/CharSequence;

    invoke-virtual {v9, v1, v3}, Landroid/widget/RemoteViews;->setTextViewText(ILjava/lang/CharSequence;)V

    const/4 v1, 0x1

    goto :goto_6

    :cond_9
    const/4 v1, 0x0

    :goto_6
    sget v3, Landroid/os/Build$VERSION;->SDK_INT:I

    if-ge v3, v6, :cond_a

    iget-object v3, v0, Landroid/support/v4/app/NotificationCompat$Style;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    iget-object v3, v3, Landroid/support/v4/app/NotificationCompat$Builder;->mLargeIcon:Landroid/graphics/Bitmap;

    if-eqz v3, :cond_a

    const/4 v3, 0x1

    goto :goto_7

    :cond_a
    const/4 v3, 0x0

    :goto_7
    iget-object v4, v0, Landroid/support/v4/app/NotificationCompat$Style;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    iget-object v4, v4, Landroid/support/v4/app/NotificationCompat$Builder;->mContentInfo:Ljava/lang/CharSequence;

    if-eqz v4, :cond_b

    sget v1, Landroid/support/compat/R$id;->info:I

    iget-object v3, v0, Landroid/support/v4/app/NotificationCompat$Style;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    iget-object v3, v3, Landroid/support/v4/app/NotificationCompat$Builder;->mContentInfo:Ljava/lang/CharSequence;

    :goto_8
    invoke-virtual {v9, v1, v3}, Landroid/widget/RemoteViews;->setTextViewText(ILjava/lang/CharSequence;)V

    :goto_9
    sget v1, Landroid/support/compat/R$id;->info:I

    invoke-virtual {v9, v1, v11}, Landroid/widget/RemoteViews;->setViewVisibility(II)V

    const/4 v1, 0x1

    const/4 v14, 0x1

    goto :goto_a

    :cond_b
    iget-object v4, v0, Landroid/support/v4/app/NotificationCompat$Style;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    iget v4, v4, Landroid/support/v4/app/NotificationCompat$Builder;->mNumber:I

    if-lez v4, :cond_d

    sget v1, Landroid/support/compat/R$integer;->status_bar_notification_info_maxnum:I

    invoke-virtual {v2, v1}, Landroid/content/res/Resources;->getInteger(I)I

    move-result v1

    iget-object v3, v0, Landroid/support/v4/app/NotificationCompat$Style;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    iget v3, v3, Landroid/support/v4/app/NotificationCompat$Builder;->mNumber:I

    if-le v3, v1, :cond_c

    sget v1, Landroid/support/compat/R$id;->info:I

    sget v3, Landroid/support/compat/R$string;->status_bar_notification_info_overflow:I

    invoke-virtual {v2, v3}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v3

    goto :goto_8

    :cond_c
    invoke-static {}, Ljava/text/NumberFormat;->getIntegerInstance()Ljava/text/NumberFormat;

    move-result-object v1

    sget v3, Landroid/support/compat/R$id;->info:I

    iget-object v4, v0, Landroid/support/v4/app/NotificationCompat$Style;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    iget v4, v4, Landroid/support/v4/app/NotificationCompat$Builder;->mNumber:I

    int-to-long v4, v4

    invoke-virtual {v1, v4, v5}, Ljava/text/NumberFormat;->format(J)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v9, v3, v1}, Landroid/widget/RemoteViews;->setTextViewText(ILjava/lang/CharSequence;)V

    goto :goto_9

    :cond_d
    sget v4, Landroid/support/compat/R$id;->info:I

    invoke-virtual {v9, v4, v13}, Landroid/widget/RemoteViews;->setViewVisibility(II)V

    move v14, v1

    move v1, v3

    :goto_a
    iget-object v3, v0, Landroid/support/v4/app/NotificationCompat$Style;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    iget-object v3, v3, Landroid/support/v4/app/NotificationCompat$Builder;->mSubText:Ljava/lang/CharSequence;

    if-eqz v3, :cond_f

    sget v3, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt v3, v12, :cond_f

    sget v3, Landroid/support/compat/R$id;->text:I

    iget-object v4, v0, Landroid/support/v4/app/NotificationCompat$Style;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    iget-object v4, v4, Landroid/support/v4/app/NotificationCompat$Builder;->mSubText:Ljava/lang/CharSequence;

    invoke-virtual {v9, v3, v4}, Landroid/widget/RemoteViews;->setTextViewText(ILjava/lang/CharSequence;)V

    iget-object v3, v0, Landroid/support/v4/app/NotificationCompat$Style;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    iget-object v3, v3, Landroid/support/v4/app/NotificationCompat$Builder;->mContentText:Ljava/lang/CharSequence;

    if-eqz v3, :cond_e

    sget v3, Landroid/support/compat/R$id;->text2:I

    iget-object v4, v0, Landroid/support/v4/app/NotificationCompat$Style;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    iget-object v4, v4, Landroid/support/v4/app/NotificationCompat$Builder;->mContentText:Ljava/lang/CharSequence;

    invoke-virtual {v9, v3, v4}, Landroid/widget/RemoteViews;->setTextViewText(ILjava/lang/CharSequence;)V

    sget v3, Landroid/support/compat/R$id;->text2:I

    invoke-virtual {v9, v3, v11}, Landroid/widget/RemoteViews;->setViewVisibility(II)V

    const/4 v3, 0x1

    goto :goto_b

    :cond_e
    sget v3, Landroid/support/compat/R$id;->text2:I

    invoke-virtual {v9, v3, v13}, Landroid/widget/RemoteViews;->setViewVisibility(II)V

    :cond_f
    const/4 v3, 0x0

    :goto_b
    if-eqz v3, :cond_11

    sget v3, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt v3, v12, :cond_11

    if-eqz p3, :cond_10

    sget v3, Landroid/support/compat/R$dimen;->notification_subtext_size:I

    invoke-virtual {v2, v3}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v2

    int-to-float v2, v2

    sget v3, Landroid/support/compat/R$id;->text:I

    invoke-virtual {v9, v3, v11, v2}, Landroid/widget/RemoteViews;->setTextViewTextSize(IIF)V

    :cond_10
    sget v4, Landroid/support/compat/R$id;->line1:I

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    move-object v3, v9

    invoke-virtual/range {v3 .. v8}, Landroid/widget/RemoteViews;->setViewPadding(IIIII)V

    :cond_11
    iget-object v2, v0, Landroid/support/v4/app/NotificationCompat$Style;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-virtual {v2}, Landroid/support/v4/app/NotificationCompat$Builder;->getWhenIfShowing()J

    move-result-wide v2

    const-wide/16 v4, 0x0

    cmp-long v6, v2, v4

    if-eqz v6, :cond_13

    iget-object v1, v0, Landroid/support/v4/app/NotificationCompat$Style;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    iget-boolean v1, v1, Landroid/support/v4/app/NotificationCompat$Builder;->mUseChronometer:Z

    if-eqz v1, :cond_12

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt v1, v12, :cond_12

    sget v1, Landroid/support/compat/R$id;->chronometer:I

    invoke-virtual {v9, v1, v11}, Landroid/widget/RemoteViews;->setViewVisibility(II)V

    sget v1, Landroid/support/compat/R$id;->chronometer:I

    const-string v2, "setBase"

    iget-object v3, v0, Landroid/support/v4/app/NotificationCompat$Style;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-virtual {v3}, Landroid/support/v4/app/NotificationCompat$Builder;->getWhenIfShowing()J

    move-result-wide v3

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v5

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v7

    sub-long v15, v5, v7

    add-long v5, v3, v15

    invoke-virtual {v9, v1, v2, v5, v6}, Landroid/widget/RemoteViews;->setLong(ILjava/lang/String;J)V

    sget v1, Landroid/support/compat/R$id;->chronometer:I

    const-string v2, "setStarted"

    invoke-virtual {v9, v1, v2, v10}, Landroid/widget/RemoteViews;->setBoolean(ILjava/lang/String;Z)V

    goto :goto_c

    :cond_12
    sget v1, Landroid/support/compat/R$id;->time:I

    invoke-virtual {v9, v1, v11}, Landroid/widget/RemoteViews;->setViewVisibility(II)V

    sget v1, Landroid/support/compat/R$id;->time:I

    const-string v2, "setTime"

    iget-object v3, v0, Landroid/support/v4/app/NotificationCompat$Style;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-virtual {v3}, Landroid/support/v4/app/NotificationCompat$Builder;->getWhenIfShowing()J

    move-result-wide v3

    invoke-virtual {v9, v1, v2, v3, v4}, Landroid/widget/RemoteViews;->setLong(ILjava/lang/String;J)V

    goto :goto_c

    :cond_13
    move v10, v1

    :goto_c
    sget v1, Landroid/support/compat/R$id;->right_side:I

    if-eqz v10, :cond_14

    const/4 v2, 0x0

    goto :goto_d

    :cond_14
    const/16 v2, 0x8

    :goto_d
    invoke-virtual {v9, v1, v2}, Landroid/widget/RemoteViews;->setViewVisibility(II)V

    sget v1, Landroid/support/compat/R$id;->line3:I

    if-eqz v14, :cond_15

    goto :goto_e

    :cond_15
    const/16 v11, 0x8

    :goto_e
    invoke-virtual {v9, v1, v11}, Landroid/widget/RemoteViews;->setViewVisibility(II)V

    return-object v9
.end method

.method public build()Landroid/app/Notification;
    .locals 1

    iget-object v0, p0, Landroid/support/v4/app/NotificationCompat$Style;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    if-eqz v0, :cond_0

    iget-object v0, p0, Landroid/support/v4/app/NotificationCompat$Style;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-virtual {v0}, Landroid/support/v4/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object v0

    return-object v0

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public buildIntoRemoteViews(Landroid/widget/RemoteViews;Landroid/widget/RemoteViews;)V
    .locals 7
    .annotation build Landroid/support/annotation/RestrictTo;
        value = {
            .enum Landroid/support/annotation/RestrictTo$Scope;->LIBRARY_GROUP:Landroid/support/annotation/RestrictTo$Scope;
        }
    .end annotation

    invoke-direct {p0, p1}, Landroid/support/v4/app/NotificationCompat$Style;->hideNormalContent(Landroid/widget/RemoteViews;)V

    sget v0, Landroid/support/compat/R$id;->notification_main_column:I

    invoke-virtual {p1, v0}, Landroid/widget/RemoteViews;->removeAllViews(I)V

    sget v0, Landroid/support/compat/R$id;->notification_main_column:I

    invoke-virtual {p2}, Landroid/widget/RemoteViews;->clone()Landroid/widget/RemoteViews;

    move-result-object p2

    invoke-virtual {p1, v0, p2}, Landroid/widget/RemoteViews;->addView(ILandroid/widget/RemoteViews;)V

    sget p2, Landroid/support/compat/R$id;->notification_main_column:I

    const/4 v0, 0x0

    invoke-virtual {p1, p2, v0}, Landroid/widget/RemoteViews;->setViewVisibility(II)V

    sget p2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v0, 0x15

    if-lt p2, v0, :cond_0

    sget v2, Landroid/support/compat/R$id;->notification_main_column_container:I

    const/4 v3, 0x0

    invoke-direct {p0}, Landroid/support/v4/app/NotificationCompat$Style;->calculateTopPadding()I

    move-result v4

    const/4 v5, 0x0

    const/4 v6, 0x0

    move-object v1, p1

    invoke-virtual/range {v1 .. v6}, Landroid/widget/RemoteViews;->setViewPadding(IIIII)V

    :cond_0
    return-void
.end method

.method public createColoredBitmap(II)Landroid/graphics/Bitmap;
    .locals 1
    .annotation build Landroid/support/annotation/RestrictTo;
        value = {
            .enum Landroid/support/annotation/RestrictTo$Scope;->LIBRARY_GROUP:Landroid/support/annotation/RestrictTo$Scope;
        }
    .end annotation

    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, v0}, Landroid/support/v4/app/NotificationCompat$Style;->createColoredBitmap(III)Landroid/graphics/Bitmap;

    move-result-object p1

    return-object p1
.end method

.method public makeBigContentView(Landroid/support/v4/app/NotificationBuilderWithBuilderAccessor;)Landroid/widget/RemoteViews;
    .locals 0
    .annotation build Landroid/support/annotation/RestrictTo;
        value = {
            .enum Landroid/support/annotation/RestrictTo$Scope;->LIBRARY_GROUP:Landroid/support/annotation/RestrictTo$Scope;
        }
    .end annotation

    const/4 p1, 0x0

    return-object p1
.end method

.method public makeContentView(Landroid/support/v4/app/NotificationBuilderWithBuilderAccessor;)Landroid/widget/RemoteViews;
    .locals 0
    .annotation build Landroid/support/annotation/RestrictTo;
        value = {
            .enum Landroid/support/annotation/RestrictTo$Scope;->LIBRARY_GROUP:Landroid/support/annotation/RestrictTo$Scope;
        }
    .end annotation

    const/4 p1, 0x0

    return-object p1
.end method

.method public makeHeadsUpContentView(Landroid/support/v4/app/NotificationBuilderWithBuilderAccessor;)Landroid/widget/RemoteViews;
    .locals 0
    .annotation build Landroid/support/annotation/RestrictTo;
        value = {
            .enum Landroid/support/annotation/RestrictTo$Scope;->LIBRARY_GROUP:Landroid/support/annotation/RestrictTo$Scope;
        }
    .end annotation

    const/4 p1, 0x0

    return-object p1
.end method

.method protected restoreFromCompatExtras(Landroid/os/Bundle;)V
    .locals 0
    .annotation build Landroid/support/annotation/RestrictTo;
        value = {
            .enum Landroid/support/annotation/RestrictTo$Scope;->LIBRARY_GROUP:Landroid/support/annotation/RestrictTo$Scope;
        }
    .end annotation

    return-void
.end method

.method public setBuilder(Landroid/support/v4/app/NotificationCompat$Builder;)V
    .locals 1

    iget-object v0, p0, Landroid/support/v4/app/NotificationCompat$Style;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    if-eq v0, p1, :cond_0

    iput-object p1, p0, Landroid/support/v4/app/NotificationCompat$Style;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    iget-object p1, p0, Landroid/support/v4/app/NotificationCompat$Style;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    if-eqz p1, :cond_0

    iget-object p1, p0, Landroid/support/v4/app/NotificationCompat$Style;->mBuilder:Landroid/support/v4/app/NotificationCompat$Builder;

    invoke-virtual {p1, p0}, Landroid/support/v4/app/NotificationCompat$Builder;->setStyle(Landroid/support/v4/app/NotificationCompat$Style;)Landroid/support/v4/app/NotificationCompat$Builder;

    :cond_0
    return-void
.end method
